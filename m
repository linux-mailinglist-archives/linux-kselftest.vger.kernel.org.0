Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F31D0D49F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2019 23:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfJKVio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Oct 2019 17:38:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37954 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfJKVio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Oct 2019 17:38:44 -0400
Received: by mail-io1-f67.google.com with SMTP id u8so24533160iom.5;
        Fri, 11 Oct 2019 14:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2fEyK46kEA/BNmICLFW/D8fkweWoO46qLnUUQCiumgw=;
        b=UGkWR9IPNmwR0PIvRa+nJWrolZGpnPlcbLdOwgSWB27qQ6UtLnMEVByTZ7TkU5tuiS
         DWWgFeDanr54ETGd+HPIE7BX3l4t5lsATasZvZhCCSsiHSx3/4kTuiDoQkQ3VVCbP14h
         ETsHdUvCQgfFs/1Z89hqRVcMetvZCVglFmWMwO3qJLwhxP1TYqJJHthYZKUIfSRshmGh
         ElglennxRiDIEuBR2lV29iLqokZWA9bsoGV0lnaisyUXppftYOKys+z+Rw3Y2fwLLg3d
         IG3GX7A4Aue+S5rO5XdwPscXs4eaGyYA791rbtglbopP6KyifIbYEQzeKAqCJvgIRLCj
         Bz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2fEyK46kEA/BNmICLFW/D8fkweWoO46qLnUUQCiumgw=;
        b=iBJRPJ1xi5AXrjX1CX2zxlusg3WClqCl+D3l0UmR7o6hZnv8kxAd1app30RLuDcqp6
         d7TYtW7ut+7ipLSYvn0xDQrB7SKOgowXNtShmYZIJNjK+clUT8e6mr13wGeJ4bGAWjsP
         fdPhCTYpNklnN442d0sLzonDb+FpYFGIlVAU4Z85DTZEMqWjLTcejNPjKsDGOnFLjB2U
         v8xoFeljoklQZ0NDJ9u6/88/Vk5wS79pK4fxirR5LJUUWBqdDV0nGrirwkOiOXYuFwYc
         PRXz9xy1EOYXmnyZqvTu0M+pMa+Jqq9xF8XTO/BhbqTzozc8XdhWoWTK0z+x2Yevdonv
         ShJw==
X-Gm-Message-State: APjAAAXfTKhZfZtLaha15H30rR12xHevGSCT4Rbyfr5H6KI0D/D4ny6k
        aTzNhf6Uj9zF9mroeBvDv/H7jWp4ZEYfk57tKCs=
X-Google-Smtp-Source: APXvYqz6LcaIgeBINadDJ7DFnHJCvhVWFSJaLfbbEF6A1MoXRK386YmdH4wKVExMUiht72OtrLo4tGPVe+yP0ng8+4g=
X-Received: by 2002:a02:5dc2:: with SMTP id w185mr19986288jaa.2.1570829923255;
 Fri, 11 Oct 2019 14:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
In-Reply-To: <20191010133518.5420-1-christian.brauner@ubuntu.com>
From:   Michael Kerrisk <mtk.manpages@gmail.com>
Date:   Fri, 11 Oct 2019 23:38:31 +0200
Message-ID: <CAHO5Pa3V7fDb_+U-v+LB+TeAU0vfJyUMs9mD4ZqUtbLpZcD4nA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clone3: add CLONE3_CLEAR_SIGHAND
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Florian Weimer <fweimer@redhat.com>, libc-alpha@sourceware.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Christian,

Why CLONE3_CLEAR_SIGHAND rather than just CLONE_CLEAR_SIGHAND?

Thanks,

Michael
