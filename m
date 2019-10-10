Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1BD2C7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 16:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfJJO1s (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 10:27:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:48286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfJJO1r (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 10:27:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 65690AC11;
        Thu, 10 Oct 2019 14:27:46 +0000 (UTC)
Date:   Thu, 10 Oct 2019 16:27:44 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [Automated-testing] syzkaller reproducers
Message-ID: <20191010142744.GA10083@rei.lan>
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!
> We discussed collecting and uploading all syzkaller reproducers
> somewhere. You wanted to see how they look. I've uploaded all current
> reproducers here:
> https://github.com/dvyukov/syzkaller-repros
> Minimalistic build/run scripts are included.

What is the reason behind statically linking the reproducers?

The difference between static and dynamic binary is a bit less than 4MB,
which gives difference of several gigabytes for the whole repo. This
amount of binary data would complicate and slow down any CI
significantly...

-- 
Cyril Hrubis
chrubis@suse.cz
