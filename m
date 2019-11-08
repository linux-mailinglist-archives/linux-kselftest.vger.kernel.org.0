Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC1F3DD9
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2019 03:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfKHCGR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Nov 2019 21:06:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46020 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfKHCGR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Nov 2019 21:06:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id y24so2933931plr.12
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Nov 2019 18:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JaGTE9xsOVFxxMt/cA2eBRyj5tRBj9D9pcr4/X/7/Hc=;
        b=uUZbZSTpPy0TgAGNv3jrIWK3JHr+zC+3C75cT059FtvmZCjpz8HRuuy0u2yKf8LKP4
         8p5F+h1RuamrezvEcl2taulHvc02s7OMp7cVqQ3JpPexXj/+tsMAdHV//CFh52TEhMZl
         yDXV+8hT+AMYciNbo8EQHAQG/1zj7/1e6P5+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JaGTE9xsOVFxxMt/cA2eBRyj5tRBj9D9pcr4/X/7/Hc=;
        b=Eq6e1OMBxDGEJKG0+6Budbam2tKNeZO2Is8DLR237qp+EVui0H8f6w/10wtinrE9I9
         BXd1arjTUqAStojilqt9tb0ro+6QkuMLfi9owuS6pv3RPZRhTaujYfGHosipkg4MD14l
         WbJAU3sO8VG0t1MEsxsayAma4N5rmWVGQ6M/YcAKA/jHQBTwaK6LLk5sYOjy9QdjMKOV
         nHOzyqNOu62nzbdZ1OIKwu+KCkwWPKKApNnicdYMw66phD4ed51azKALVtXmsIiiZose
         PE+7P7DWLRUQalmbK1GR1hkqJN0Hnr8svODy+CLYhlYDhhUG5UFnO33K+kdKj10Tyv/N
         EUOw==
X-Gm-Message-State: APjAAAUmvJEzd3DSFuIsmcVnmOkt9WhZY3+qsbT/wtJZPmWfSkaDwKjF
        AbZXankAqeBP6BbpTQ1cFjchNQ==
X-Google-Smtp-Source: APXvYqzkaUADYo9WHWLx3wLlN7f1AHNdmQF1IptwXglLCWu+FofvB9G8cJhnDv0ifrd1RUFPPxwZZA==
X-Received: by 2002:a17:90a:3281:: with SMTP id l1mr9999852pjb.43.1573178776398;
        Thu, 07 Nov 2019 18:06:16 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p3sm4846913pfb.163.2019.11.07.18.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 18:06:15 -0800 (PST)
Date:   Thu, 7 Nov 2019 21:06:14 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Geoffray <ngeoffray@google.com>,
        kernel-team@android.com, Hugh Dickins <hughd@google.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] memfd: Fix COW issue on MAP_PRIVATE and
 F_SEAL_FUTURE_WRITE mappings
Message-ID: <20191108020614.GA99567@google.com>
References: <20191107195355.80608-1-joel@joelfernandes.org>
 <20191107170023.0695732bb67eb80acd4caee5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107170023.0695732bb67eb80acd4caee5@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 07, 2019 at 05:00:23PM -0800, Andrew Morton wrote:
> On Thu,  7 Nov 2019 14:53:54 -0500 "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > F_SEAL_FUTURE_WRITE has unexpected behavior when used with MAP_PRIVATE:
> > A private mapping created after the memfd file that gets sealed with
> > F_SEAL_FUTURE_WRITE loses the copy-on-write at fork behavior, meaning
> > children and parent share the same memory, even though the mapping is
> > private.
> 
> That sounds fairly serious.  Should this be backported into -stable kernels?

Yes, it should be. The F_SEAL_FUTURE_WRITE feature was introduced in v5.1 so
v5.3.x stable kernels would need a backport. I can submit a backport tomorrow
unless we are Ok with stable automatically picking it up (I believe the
stable folks "auto select" fixes which should detect this is a fix since I
have said it is a fix in the subject line).

thanks,

 - Joel

