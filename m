Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F934ABD5B
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2019 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405895AbfIFQLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Sep 2019 12:11:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34269 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbfIFQLv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Sep 2019 12:11:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id h2so6368ljk.1;
        Fri, 06 Sep 2019 09:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQ5QA0/NvRUPeXoFqTn/cvTBYo4Y9BoVqLKZLkVrDU0=;
        b=TYy/j2oxPTHM0ZIYs1/e12i5n5PreW9V8+ZuJHdT3vYnJIPrIb+Gk9OOgJYyTcohzy
         aqsFv5eydpT4afd/zErh1157RZX7IrKkfwHPrLSvivy8U1Dg86xdO4Xd2gOZ6wCe4mS3
         vjqAMpNiYfPkyNdWmg1LWR1wUCYu1TPnKuwn4SJMCD33a4zM3120yyGZUajwmOzbRgqw
         6yQIt0i49RYnch2DAWLkF6aD4+aCwZAw0j7fnups1eEJCkEvEf1sz9AliS7tvvlpTsCS
         sTIJPc7WfbgovrWNy6y7vHynfT9hvFoodAyAEYnhF8Ma+c2yqVEhbWKF+YTKUajlVPJb
         ZQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQ5QA0/NvRUPeXoFqTn/cvTBYo4Y9BoVqLKZLkVrDU0=;
        b=ryy+iUE3OniDXF4VXfTFZ1wub57GlOb1uCU6wfZ5frK2ZiFD0MSm5sxTf5Af0E/vnS
         s1rHtyoK3VLNCb15lXUHSly3ObVp0ZLX3LMZOkXnpEUloJ8WGmPntE6zaeyJW52Toahk
         cTwHd1uovTF9QarVtU6PpyTrgBQFIU3gAD3pg5JCQXvoCi/AJdc9EOT8fUR0/WY7MB2S
         9h6LFPUCnPU9JLqO9Ql3ECv3j2KD6YS1D8Bdmqc2xdQ9vGqPel5nH+s5RADx8KnJRWBp
         gFLUg1bYT9TLwt2V1E4LEXYGESMw2iCFvQAW/Binv2B6u4V0HwxKA2Ec9edZlpJDoqtd
         r5DA==
X-Gm-Message-State: APjAAAWO3s5r/Czg6Gm5b5tE2LRNygFSBP/Om9YR5m023NOAig6taYq7
        gn4Y9u3B3bjIpkLzLqP2oT/pQ/e0GUPcVwBUknw=
X-Google-Smtp-Source: APXvYqw4JRmBRiHZwAK93SX7BYtRzdAOrfYf2K2bqh+junncmdBB0S6VY8c0NVfW0OrEC3LJ3X/d7Vgd9xzzs8PeTt4=
X-Received: by 2002:a2e:9c99:: with SMTP id x25mr6219217lji.9.1567786308784;
 Fri, 06 Sep 2019 09:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <1567771541-7690-1-git-send-email-sj38.park@gmail.com> <3531717b-fa9d-ac94-57ec-0eb501d1ad3b@kernel.org>
In-Reply-To: <3531717b-fa9d-ac94-57ec-0eb501d1ad3b@kernel.org>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Fri, 6 Sep 2019 18:11:22 +0200
Message-ID: <CAEjAshr=JqVpF651eSZYFhwVAMNZ29LWcfrH07K_M9GU=hPnvg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Fix '--build_dir' option
To:     shuah <shuah@kernel.org>
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 6, 2019 at 5:51 PM shuah <shuah@kernel.org> wrote:
>
> On 9/6/19 6:05 AM, SeongJae Park wrote:
> > kunit fails to run with '--build_dir' option because the option is not
> > properly sent to kernel running procedure.  This commit fixes the
> > problem.
>
> Can you please include the failure you are seeing in the commit log

Yes, I will.


Thanks,
SeongJae Park

>
> thanks,
> -- Shuah
>
>
