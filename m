Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09BD54C418
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2019 01:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfFSX0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jun 2019 19:26:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37092 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfFSX0u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jun 2019 19:26:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id 19so501103pfa.4;
        Wed, 19 Jun 2019 16:26:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VoHSdmKyib3uRO7GJhghBEXGKbxkfPFAuXTbi71TT84=;
        b=GSRkg1mE/cLWT4P6HAYuWSN5mTalv99P675VO2yNhUk9dGnHx9BG36++acLgOjcOAi
         w1m0vB21NLTLxEIDNDEZuPc+QbGHNjAJCR7YTtfmPSY3ynMycXLuK3fX5roSeXWngdpn
         6mS+hqSlq+FY5sNnYIaeP10mKAZGdtZqxWHAOTwDCZ/o4Poqgct0T87X/cEPb3xxAZ7u
         JSZZ4lmC1T2YA4qmEaJjCx2F/jNGvCjK0TcLkXwAY/0vWJ/FnI+GdZMcE5AWp5XFj2br
         +ebuZhdc7Gnfd2xQBP8PIWVvmdASqYLRLOUsQ/+1z34akeaSd3hld69IBmBRLx+OG1qG
         126g==
X-Gm-Message-State: APjAAAXmcaW3vGxZVHj1rcLrCRcpYCyMSHCSEhAa6O8KS6t5TR09ZKeg
        VRuJvRCj1lGxPLKtreSC5DU=
X-Google-Smtp-Source: APXvYqzWY+iJV2rJ7oMbWcuY1EtaQxtptLnB3/bb0lhh1VnU5z0Trfb87t5lzXcgwQ3uU8K2iRlR8A==
X-Received: by 2002:a17:90a:d3d7:: with SMTP id d23mr12995731pjw.26.1560986809433;
        Wed, 19 Jun 2019 16:26:49 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s5sm18464056pgj.60.2019.06.19.16.26.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 16:26:47 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 2CDD14075D; Wed, 19 Jun 2019 23:26:47 +0000 (UTC)
Date:   Wed, 19 Jun 2019 23:26:47 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2.5 2/3] firmware: Add support for loading compressed
 files
Message-ID: <20190619232646.GE19023@42.do-not-panic.com>
References: <20190611122626.28059-1-tiwai@suse.de>
 <20190611122626.28059-3-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611122626.28059-3-tiwai@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry for the late review... Ah!

On Tue, Jun 11, 2019 at 02:26:25PM +0200, Takashi Iwai wrote:
> @@ -354,7 +454,12 @@ module_param_string(path, fw_path_para, sizeof(fw_path_para), 0644);
>  MODULE_PARM_DESC(path, "customized firmware image search path with a higher priority than default path");
>  
>  static int
> -fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
> +fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
> +			   const char *suffix,
> +			   int (*decompress)(struct device *dev,
> +					     struct fw_priv *fw_priv,
> +					     size_t in_size,
> +					     const void *in_buffer))

I *think* this could be cleaner, I'll elaborate below.

> @@ -645,7 +768,13 @@ _request_firmware(const struct firmware **firmware_p, const char *name,
>  	if (ret <= 0) /* error or already assigned */
>  		goto out;
>  
> -	ret = fw_get_filesystem_firmware(device, fw->priv);
> +	ret = fw_get_filesystem_firmware(device, fw->priv, "", NULL);
> +#ifdef CONFIG_FW_LOADER_COMPRESS
> +	if (ret == -ENOENT)
> +		ret = fw_get_filesystem_firmware(device, fw->priv, ".xz",
> +						 fw_decompress_xz);
> +#endif

Hrm, and let more #ifdef'ery.

And so if someone wants to add bzip, we'd add yet-another if else on the
return value of this call... and yet more #ifdefs.

We already have a list of paths supported. It seems what we need instead
is a list of supported suffixes, and a respective structure which then
has its set of callbacks for posthandling.

This way, this could all be handled inside fw_get_filesystem_firmware()
neatly, and we can just strive towards avoiding #ifdef'ery.

Since I'm late to review, this could be done in the future, but I do
think something along these lines would make the code more maintainable
and extensible.

  Luis
