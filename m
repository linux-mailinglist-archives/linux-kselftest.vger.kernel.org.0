Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77340DEE56
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfJUNuS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 09:50:18 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:34807 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbfJUNuR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 09:50:17 -0400
Received: by mail-il1-f193.google.com with SMTP id c12so12072946ilm.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2019 06:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zDje2pQipVT5uUcMV42nQggbrwWDyHfBKgdKQtpAJaM=;
        b=MVs134l65t5BTYPgjlww6BVOq5twBjNypJjDDdRiPR03tSZB5KmazmM7KWo0unpIqY
         DGfnpuKRhxj29fSyYoXVwvctoq9Q1DSH8lungvp2tYJXOGkAlu53ZxxTandAuRwP+ohM
         ldRIoOrXCcESfHKgPTgWeya0dnmCyqEJL6uTuZMojIF8tVqFffYDkMCYtq7us0wz0RS9
         sPL0JRtHvy4dyXwlwTyA/IiPbPOXeyVcn4hpwZnLUQXcSQ1AIoGVaNlOZ0c768aZGOYL
         r1usNZPqRHGTVY+LqkB+7U0eM4c9LTFw6HkCBzV/Cco8uqcFQ4WSbf2ldOIXD5hmaV8g
         mFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zDje2pQipVT5uUcMV42nQggbrwWDyHfBKgdKQtpAJaM=;
        b=npsmFs/ZpTi8Z1SHkSmgkuwDMO8MfdicLDe2JZT7NW5YQThOZCvLRVw40YC1b7g1Ro
         YJ6Jbe7zBJ8s7J9UAayAQYfnBh1yq59TzLJJV4fENVoWIsc2Cg5LeqL0mM/dQZdE925Z
         bpb5CU0UCnSXrPxaku1DFDSKF44i+CIjKfgvVi0DQecZ5x2gg3xwxQuy+kX0hmlSOv5T
         24Icyvd/kFaG6noFoAhIV8Tw83tuaL+LV6ceZF8y6bcLiIBtcCiHwrbmAFrcIX12tD6S
         w7ZxdsvHOIzP22IFCC7FwjRadEYbJiGkSGsIfnMjb0J/FggBLMToVvATHdef914nBLnc
         K3Mw==
X-Gm-Message-State: APjAAAWtOI/pJgcsiCsl9GYhj4/Oa6hDy09qA2928eRcEM+UH12PLeot
        PL0384Iqqy6vW/C6WNqbkwDAsA==
X-Google-Smtp-Source: APXvYqyDQRodzUn85zMwBicd+7pAm0+7swizBLdALYp5OmQGKnooPyG4JtAFft9FRL/070YUpXxrJg==
X-Received: by 2002:a05:6e02:68f:: with SMTP id o15mr25394236ils.210.1571665816762;
        Mon, 21 Oct 2019 06:50:16 -0700 (PDT)
Received: from cisco ([2601:282:902:b340:c86c:807:8b9d:1010])
        by smtp.gmail.com with ESMTPSA id v19sm4508156iol.24.2019.10.21.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 06:50:15 -0700 (PDT)
Date:   Mon, 21 Oct 2019 07:50:13 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        rong.a.chen@intel.com, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, lkp@lists.01.org, luto@amacapital.net,
        shuah@kernel.org, songliubraving@fb.com, tyhicks@canonical.com,
        wad@chromium.org, yhs@fb.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] seccomp: fix SECCOMP_USER_NOTIF_FLAG_CONTINUE test
Message-ID: <20191021135013.GD28452@cisco>
References: <20191021084157.GG9296@shao2-debian>
 <20191021091055.4644-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021091055.4644-1-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Oct 21, 2019 at 11:10:55AM +0200, Christian Brauner wrote:
> The ifndef for SECCOMP_USER_NOTIF_FLAG_CONTINUE was placed under the
> ifndef for the SECCOMP_FILTER_FLAG_NEW_LISTENER feature. This will not
> work on systems that do support SECCOMP_FILTER_FLAG_NEW_LISTENER but do not
> support SECCOMP_USER_NOTIF_FLAG_CONTINUE. So move the latter ifndef out of
> the former ifndef's scope.
> 
> 2019-10-20 11:14:01 make run_tests -C seccomp
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-7.6-0eebfed2954f152259cae0ad57b91d3ea92968e8/tools/testing/selftests/seccomp'
> gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
> seccomp_bpf.c: In function ‘user_notification_continue’:
> seccomp_bpf.c:3562:15: error: ‘SECCOMP_USER_NOTIF_FLAG_CONTINUE’ undeclared (first use in this function)
>   resp.flags = SECCOMP_USER_NOTIF_FLAG_CONTINUE;
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> seccomp_bpf.c:3562:15: note: each undeclared identifier is reported only once for each function it appears in
> Makefile:12: recipe for target 'seccomp_bpf' failed
> make: *** [seccomp_bpf] Error 1
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-7.6-0eebfed2954f152259cae0ad57b91d3ea92968e8/tools/testing/selftests/seccomp'
> 
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 0eebfed2954f ("seccomp: test SECCOMP_USER_NOTIF_FLAG_CONTINUE")
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Tycho Andersen <tycho@tycho.ws>
