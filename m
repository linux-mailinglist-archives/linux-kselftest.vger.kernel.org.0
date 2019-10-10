Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82FAFD2C92
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2019 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfJJOal (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Oct 2019 10:30:41 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:34218 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfJJOal (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Oct 2019 10:30:41 -0400
Received: by mail-qk1-f172.google.com with SMTP id q203so5806552qke.1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2019 07:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oNCPbhC8wzdf80R8apAVzjMEvMwAA55ELwlddqmo6j8=;
        b=JE2GxwQ0U+wGKPxLOmW5rMD990Vv4HvkORCYFJpDnRuaJeCqPWpR8JJ0+sl5da2zhK
         O9xD2LbQm9cbck9a0m+1XlFub/AFVZEAiNFJJ+SjitdhOzmYFZxTDy8Nf0lZSlNniJSd
         hoMIxBdzSDdhjOfiZ4DPHXmd/w6yAcn8tnq1Jf1n34BZnUGNriUm3XeOwDQH98Gvatb2
         5KJ4ETPRWvD03jjAPA+O03ao/wZiSsKmKK44tPW7wJaa+ZQBPCeShFp4oyP2IjDtg2IN
         BzqRwMsgk5+KXXHsSKThwa+O4NpNqJ9tWwKuRr7z3q5uZP81e6MlR4C1pg8zU6Tq8/5g
         j8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oNCPbhC8wzdf80R8apAVzjMEvMwAA55ELwlddqmo6j8=;
        b=HH6tiBMoc3WJKRsKMKPPBl/fyqdAlMC7PYnpzQLGcjRlI1iYpbf3BBjeh+dsL/IZKM
         4/c8x8/GM8BtpSE8NK9cNiA5K+F6EDTm0X5xXkDX0QzbFPDYKxTYKnEOSGuwhSw3eAlQ
         RJ1/CDJ1xBqw6ih5tRG2TAPF0JXph4lFo491uQ12oCtTTpISF/9bFAbvaWRLE/YrpU3R
         /TSpzYHInJrjgNN7oTWBLPV+SKWBOzprCYXklvnulku3dquuh+gt8vE2h/lQ5/VroBlr
         mv+FY1FfBI9So2EkVbKDdDl1mCOfL3Cz/kKPJ2uW7bmen1Q8ZKV7USFlf40ol2h2NRL5
         0zWA==
X-Gm-Message-State: APjAAAV+L+Uz86TmOt1D04WtGoE44S41J97KlEW6dxsrrYrrBcHz/Cwt
        vgxCdvLCLGFna4SupNjAOQS5S3SyGcdT1snFVrvYEQ==
X-Google-Smtp-Source: APXvYqwh4T2EynqORRvfYSX3ld1oEMww7ThRy9esYa11rqAmnY59x9YLlT1+/xTOFqVmLPBoMEjaAFU9z0C5cQVy0TQ=
X-Received: by 2002:a37:65d0:: with SMTP id z199mr9287814qkb.407.1570717839400;
 Thu, 10 Oct 2019 07:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YjOxmOzzPt_xaYE44QNZfq9haNfbnVBrTnPXe7zuSEfA@mail.gmail.com>
 <20191010142744.GA10083@rei.lan>
In-Reply-To: <20191010142744.GA10083@rei.lan>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Oct 2019 16:30:27 +0200
Message-ID: <CACT4Y+ZiC_m-U1+Zxs3hhOM7j2seKKjX=H9eabUAGCctm1+8OQ@mail.gmail.com>
Subject: Re: [Automated-testing] syzkaller reproducers
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        automated-testing@yoctoproject.org, kernelci@groups.io,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 10, 2019 at 4:27 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > We discussed collecting and uploading all syzkaller reproducers
> > somewhere. You wanted to see how they look. I've uploaded all current
> > reproducers here:
> > https://github.com/dvyukov/syzkaller-repros
> > Minimalistic build/run scripts are included.
>
> What is the reason behind statically linking the reproducers?
>
> The difference between static and dynamic binary is a bit less than 4MB,
> which gives difference of several gigabytes for the whole repo. This
> amount of binary data would complicate and slow down any CI
> significantly...

Simply being able to run programs on a different machine. Dynamic
binaries generally don't run on a different linux machine. If you can
build dynamic binaries so that they run on test machine, feel free to
drop -static.
