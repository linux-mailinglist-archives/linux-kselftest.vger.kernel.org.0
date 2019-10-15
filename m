Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3EE2D779E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2019 15:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbfJONoL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Oct 2019 09:44:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:54500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728880AbfJONoK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Oct 2019 09:44:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3679BAB9D;
        Tue, 15 Oct 2019 13:44:09 +0000 (UTC)
Date:   Tue, 15 Oct 2019 15:44:07 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        Dhaval Giani <dhaval.giani@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jan Setje-Eilers <jan.setjeeilers@oracle.com>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [Automated-testing] syzkaller reproducers
Message-ID: <20191015134407.GA12523@rei.lan>
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <CACT4Y+ZaN900gwx=PHS10hrKofZib7HA7JFxE_DkwChyttYW+A@mail.gmail.com>
 <876a2abe-41ab-5819-4ae8-ad26186d0d1c@kernel.org>
 <226099bc-9763-3a73-e26a-b292f601494c@kernel.org>
 <20191011180248.GA24089@rei.lan>
 <b715f3d7-547f-9a43-dc41-2e46ec3bfd51@kernel.org>
 <20191014085414.GB31760@rei.lan>
 <CACT4Y+aKbgT=i8C5aZvp8ZV52PamGm=GdnR6kQecczLQOQSGqA@mail.gmail.com>
 <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62903a33-8ffc-56b6-de1a-539f10b5de2a@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!
> >> I do not think that these scripts are ever supposed to be the used in
> >> production testing, you need much more than this to produce results
> >> reliably. I would expect that they are supposed to be a form of very
> >> minimal documentation.
> > Yes, I just added them as quick hints: some repros are 32-bits; each
> > needs a new dir; some external timeout is needed for each test.
> Thank you again for the collection of repro C programs!
> 
> Hitting a lot more crashes with the collection of repro C programs than 
> in all the hours of running Syzkaller. Wonder why? Any idea? This is 
> with the same kernel and VM that Syzkaller is run on.

I would guess that these reproducers are product of countless hours of
fuzzing, so it's about to be expected...

-- 
Cyril Hrubis
chrubis@suse.cz
