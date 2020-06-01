Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BFA1EA4BA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jun 2020 15:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgFANPT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jun 2020 09:15:19 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40570 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgFANPS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jun 2020 09:15:18 -0400
Received: by mail-pj1-f65.google.com with SMTP id s88so4512615pjb.5;
        Mon, 01 Jun 2020 06:15:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Izs7uCynhi/NNglgx/V1ZW/qPxVkAERiC6Myxm4w4Qs=;
        b=dDTk8akgspWLM30IWIdXJdpJ7KBvd0em8YJcb5n4K+MtLmy71t4nv81c/aqRf4/Hi2
         eFPUH3rQ26MjvRXW/uEzMiaOkPqQOFlR4epYbT3wSnhhCkFcwfQedMaQ9yxMA7AdKH6C
         Ot5qlIE0PuqqUKX/H8aL5RBv/DzJH7i55e40URg8K0pLq4f4ehinpoaFdmFt4wztPYGy
         Ohr3JD8RXdEIvwCd4rb35cf1mp7KWLDDcHjCZwBXKV+c4jmOosaS+K4PAK1ovLyD1YLh
         KYstu6o/9iHFaeGDFW2q5bV/cpIG9xxAfLmmMszeSZAe95zcXk8WUj60UPAq0//WSHpp
         YkPA==
X-Gm-Message-State: AOAM531K0AH6kKH+9mZnAnnvh6Kf8XwvQSf33XhlcML0SRM1HK1WC+Oe
        c69ptlYJPeYpbXwiV5GhndP+1vOe+X4=
X-Google-Smtp-Source: ABdhPJyQ6F1FP/Xu25YB8Xn9yV73P1PEVA+hgogCtOY/fhL6Fuw98xhVAIVRP604ts4WM4WE3rtW3Q==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr19401801ply.139.1591017316819;
        Mon, 01 Jun 2020 06:15:16 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 131sm14736093pfv.139.2020.06.01.06.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:15:15 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 254F140251; Mon,  1 Jun 2020 13:15:15 +0000 (UTC)
Date:   Mon, 1 Jun 2020 13:15:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
Subject: Re: [PATCH 1/4] lib: Make prime number generator independently
 selectable
Message-ID: <20200601131515.GH11244@42.do-not-panic.com>
References: <159067751438.229397.6746886115540895104.stgit@devnote2>
 <159067752610.229397.10253900294111245982.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159067752610.229397.10253900294111245982.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 28, 2020 at 11:52:06PM +0900, Masami Hiramatsu wrote:
> Make prime number generator independently selectable from
> kconfig. This allows us to enable CONFIG_PRIME_NUMBERS=m
> and run the tools/testing/selftests/lib/prime_numbers.sh
> without other DRM selftest modules.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
