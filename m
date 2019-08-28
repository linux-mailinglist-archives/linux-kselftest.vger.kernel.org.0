Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DABB9F882
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 05:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfH1DCh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Aug 2019 23:02:37 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39287 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfH1DCh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Aug 2019 23:02:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id z3so504091pln.6;
        Tue, 27 Aug 2019 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EVdeCyf+Dre527jjy+znlXDOFiaoUxVGSV52G0y0lqE=;
        b=TOcYBSfe9DBMW5GPB5A9ilKGvlI2vJSk+dor2a0ec0k7vZpCHBfpGohC2g1/vw37LN
         MQS1syL9hKOoK7iKdXZmowPyvCYLdRe0fZ1l3rVymZVcC6Alm36iB0buT9u/ppiVfrSB
         hVLS3RSNPH0e78n+1QgBNBIqYmFonHNjRQe/wJAZMUig9GKyeS2230BiJuvVAByWuwlU
         y2uBVbKC0syPvgSjoaObDzS8ZYilqc3eKZkFt9U38ex5skAX03snPcdcWKFXTpyBDjNY
         PpwFYmvQFJCGAuEB3Mfa94oB5eqm9MeVdj+pwRQnn3icrz7y0/RDCT6PhQMSsVJbpdVv
         uAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EVdeCyf+Dre527jjy+znlXDOFiaoUxVGSV52G0y0lqE=;
        b=BgAG5a/zirVktr09ojEOQT94vTfQHdMsDJR9nO7chprpKt65KYl1xwjyd6HA4zuED/
         9tVEyL9misU4aL1Nf34lrn3AJf0zJEKckqNveW2qAcU+iusRCSGenHVQHWSqpwbx8ZNe
         V+9t22btp03dh3hxArXDl3UW1MK0kTT1skwOEGGI3NObUQTWeXjxECRuIiegbTRXyoPK
         z2QYuyH2ZgZNjC7hGWk/zk0ViDQeqbRFsC55m16e/rRLjCa6wzWkJwytY4DUB1KAgTAk
         whAjXS/Clqnrrd7EEQVLhwYu++Rn78Zhwcu5Zg7vJuLBRsZcmEuJ+CqA6ox29fSaIPhz
         quyQ==
X-Gm-Message-State: APjAAAU83/KcmG0wX4gWT+aLVlkHXCEwpelRsKLeSEa9BVVXGFhoVwje
        q0pGlx3UbMivl14r4MNTUWg=
X-Google-Smtp-Source: APXvYqy1wfsldbfqxCgWrZeeaMWDOEH5Htif11waPnaXWPN2MnBS8r/n23K0stabgpOhS6P5U2lw4w==
X-Received: by 2002:a17:902:3265:: with SMTP id y92mr734078plb.343.1566961355738;
        Tue, 27 Aug 2019 20:02:35 -0700 (PDT)
Received: from localhost ([39.7.47.251])
        by smtp.gmail.com with ESMTPSA id y14sm659858pge.7.2019.08.27.20.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 20:02:34 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:02:31 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     shuah@kernel.org, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        frowand.list@gmail.com, sboyd@kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1] printk: add dummy vprintk_emit for when
 CONFIG_PRINTK=n
Message-ID: <20190828030231.GA24069@jagdpanzerIV>
References: <20190827234835.234473-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827234835.234473-1-brendanhiggins@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On (08/27/19 16:48), Brendan Higgins wrote:
> Previously vprintk_emit was only defined when CONFIG_PRINTK=y, this
> caused a build failure in kunit/test.c when CONFIG_PRINTK was not set.
> Add a no-op dummy so that callers don't have to ifdef around this.
> 
> Note: It has been suggested that this go in through the kselftest tree
> along with the KUnit patches, because KUnit depends on this. See the
> second link for the discussion on this.

Is there any reason for kunit to use vprintk_emit()? Can you switch
to pr_err()/pr_info()/pr_foo()?

vprintk_emit() function is pretty internal. It's not static because
drivers/base/core.c wants to add some extra payload to printk()
messages (extended headers, etc).

	-ss
