Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4D68DF2D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 18:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfJUQUK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 12:20:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41525 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfJUQUJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 12:20:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so8095475pga.8
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2019 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zLEL7dsDenynfjgsbXg0GRcq+FGIXiWp49qmwa6PWUY=;
        b=COLjEalPHT6tAkyGMrtBqQjqOofnF+3uPIuhh1phIXfevPs1f0IKX7ZuK789YaXptu
         yBkwsdP+50j2XNM/mEsGxLKyMnRhC5CbW+UTMH2LCgu9WVXdLg/KqUxChY0ROapw4YgJ
         dG3hCYiPgrPTVTFT5QTt5U9yDjFhzLyHjxp9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zLEL7dsDenynfjgsbXg0GRcq+FGIXiWp49qmwa6PWUY=;
        b=FHqszNIwhheVuQBYVSqjuAQPD0QytmkzlXsb5k/gDQcsfZzcFSC0n+4Q9LZ5Q4ok9E
         uzSKzwpggOYGZUp83VThEeLzgJOzaZU3RobVM2tBEi7lOvNj8UWKW+6gtVsR8dktNbtL
         nXxcZsgQT90E9ppVHmHF67/j9YVll+8zG5V5egQ3FjAEUXbojdsU/8xPlDZb41wIqbJ/
         wkVYvbY9OrsVDmMXKZm9IKOjoJMS2Pjlqyw+AR7GPh0hEt0AcvcydrTAEsvIZ7qTYSVh
         drmLiFWOHY1iNfASZxDLuidaIdIpfr7UQHOcRbBhCvNIpjwdOnGd3BCa6egE/AFMXfxn
         aYdg==
X-Gm-Message-State: APjAAAXmu50i1mcuGRgWZdH17spGXuX3Y0L6oueYnex7nL4g9l4vyVB8
        n7gHAboTQSGp++pFIVi17CMnAA4OvaM=
X-Google-Smtp-Source: APXvYqz9cCvZapa3UUtQmIIq4otAzcu5EyoBwpoNlgbPU8XVnJFoJLAvWGSMoDt95Avmw7kJ1GSBXA==
X-Received: by 2002:a63:5b0c:: with SMTP id p12mr4553783pgb.196.1571674808952;
        Mon, 21 Oct 2019 09:20:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 30sm17461316pgz.2.2019.10.21.09.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 09:20:08 -0700 (PDT)
Date:   Mon, 21 Oct 2019 09:20:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, rong.a.chen@intel.com,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        lkp@lists.01.org, luto@amacapital.net, shuah@kernel.org,
        songliubraving@fb.com, tyhicks@canonical.com, wad@chromium.org,
        yhs@fb.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] seccomp: fix SECCOMP_USER_NOTIF_FLAG_CONTINUE test
Message-ID: <201910210919.9187DFE5@keescook>
References: <20191021084157.GG9296@shao2-debian>
 <20191021091055.4644-1-christian.brauner@ubuntu.com>
 <20191021135013.GD28452@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021135013.GD28452@cisco>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 21, 2019 at 07:50:13AM -0600, Tycho Andersen wrote:
> On Mon, Oct 21, 2019 at 11:10:55AM +0200, Christian Brauner wrote:
> > The ifndef for SECCOMP_USER_NOTIF_FLAG_CONTINUE was placed under the
> > ifndef for the SECCOMP_FILTER_FLAG_NEW_LISTENER feature. This will not
> > work on systems that do support SECCOMP_FILTER_FLAG_NEW_LISTENER but do not
> > support SECCOMP_USER_NOTIF_FLAG_CONTINUE. So move the latter ifndef out of
> > the former ifndef's scope.
> > 
> > 2019-10-20 11:14:01 make run_tests -C seccomp
> > make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-0eebfed2954f152259cae0ad57b91d3ea92968e8/tools/testing/selftests/seccomp'
> > gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
> > seccomp_bpf.c: In function ‘user_notification_continue’:
> > seccomp_bpf.c:3562:15: error: ‘SECCOMP_USER_NOTIF_FLAG_CONTINUE’ undeclared (first use in this function)
> >   resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > seccomp_bpf.c:3562:15: note: each undeclared identifier is reported only once for each function it appears in
> > Makefile:12: recipe for target 'seccomp_bpf' failed
> > make: *** [seccomp_bpf] Error 1
> > make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-0eebfed2954f152259cae0ad57b91d3ea92968e8/tools/testing/selftests/seccomp'
> > 
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Fixes: 0eebfed2954f ("seccomp: test SECCOMP_USER_NOTIF_FLAG_CONTINUE")
> > Cc: linux-kselftest@vger.kernel.org
> > Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Reviewed-by: Tycho Andersen <tycho@tycho.ws>

Thanks! Applied to my for-next/seccomp tree.

-- 
Kees Cook
