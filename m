Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F23B610DE33
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Nov 2019 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfK3QNE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Nov 2019 11:13:04 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40932 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbfK3QNE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Nov 2019 11:13:04 -0500
Received: by mail-pg1-f194.google.com with SMTP id k25so117473pgt.7
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Nov 2019 08:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ODJuHGe9WgQW36Ci2aMzJGsTEI0RMME9CeNAPNQ613E=;
        b=eCHYX35v0tNsJ8Wyr7huWqSL/Q7uu9HMJts4X7sI/QKLD3KSpwVU1yKPvnWbgBDkck
         w55L5neeBImSshB4MOgvDxkc/9a3orK3a1S1HHbjOdPtVF8JRjkP0b1vdUZecBgtQ4Bb
         d660NmRHJmW/YEooGXS1R++4WmwRxc6UkSjVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ODJuHGe9WgQW36Ci2aMzJGsTEI0RMME9CeNAPNQ613E=;
        b=epJepJgrsmYel0ODaSnOUZolVsLvjjnV2QSQckiEruZ8F6sLrx4XQPdvzl2I4TTQyr
         zjKUftgT05JSPlWlqRFy215ppmZ5VM+MU7T2+ACLTAHQp0B+CFeW5dAQA3ivVoFs9psh
         PQe3RlN5Bs2ik1sEIM3PYOdNmOmzcxsYR5yF/3BcotvED26It2fb9Pdq7GjkoxOshMBe
         jHOt7xHsfuvGraVJHdWkx8Fx/iNwDboWk9Bovz70rEwtj4UI7STocq4CmGwNF8XjeSAx
         NPoNhgZ7JwsIa6VBX+EhSK7djTdErLbjjgEXVqVXTM+i0m6FNWMBGakBmpYNROfFqZ7j
         nOgg==
X-Gm-Message-State: APjAAAUOewPNzofQNVC6WlUu8dY3q1r7HnATtuXCzLSi+r9ugqWijCAD
        32UFtDW0Nee5+tVe0yqFVY0xrw==
X-Google-Smtp-Source: APXvYqwvXF4TzszA69py9gZ9mkRu3KVHToAXHaiaVpGpYAkkePvJ1gRXWxfBHEFfpcptgaOJhaJtkw==
X-Received: by 2002:a62:5e04:: with SMTP id s4mr64130438pfb.63.1575130383668;
        Sat, 30 Nov 2019 08:13:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 67sm19071797pfw.82.2019.11.30.08.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 08:13:02 -0800 (PST)
Date:   Sat, 30 Nov 2019 08:13:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] tools/testing/selftests/seccomp: change USER_NOTIF_MAGIC
 definition
Message-ID: <201911300811.7D70D30@keescook>
References: <20191129055128.25952-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129055128.25952-1-jcmvbkbc@gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 28, 2019 at 09:51:28PM -0800, Max Filippov wrote:
> USER_NOTIF_MAGIC is used to both initialize seccomp_notif_resp::val and
> verify syscall resturn value. On 32-bit architectures syscall return
> value has type long, but the value of USER_NOTIF_MAGIC has type long
> long because it doesn't fit into long. As a result all syscall return
> value comparisons with USER_NOTIF_MAGIC are false. This is also reported
> by the compiler when '-W' is added to CFLAGS.

Hi! Thanks for sending this. There is already a patch in the pipeline
for getting it fixed; it should show up in Linus's tree soon:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/seccomp&id=223e660bc7638d126a0e4fbace4f33f2895788c4

-- 
Kees Cook
