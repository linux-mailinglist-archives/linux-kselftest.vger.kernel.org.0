Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0E018FD91
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Mar 2020 20:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgCWTZE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 15:25:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46334 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbgCWTZE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 15:25:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id r3so6318505pls.13
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Mar 2020 12:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rPnPEDtKkbhlSrwIDL6PW6t3VVGfbYBFp7NvAloc0iU=;
        b=sfQnsXjIWtuUaNkNjkq1645xDvzSwYj4KKzzlXQefM/UILQCV8xsyn8oGKF2zm+FDF
         UJ267VnsJnrj2eA0kigh1LjdFqg5jQmKSYVy+SxlFetVDPg+U0hBmpNta81LXfd4fh/0
         UlioblXsm9Ae+2qNcIHbkyqd4XaAkIIy/x1A8DVP4+/H7hOcFHay35yIwziwWNkUEaCM
         3zxTzPuJ2f2CC/TnO0fPBBMFdQONufRWSBUw2o6sOMKYZU6UFLK2REbJ8OrCqjAx2Qqy
         dVeFyaceNkSTn/dMNBsEMjF7msxOR/nzUZqj2GAcup6vxrbcVe6wlLcsLA1kYcadi5Qx
         Gdvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rPnPEDtKkbhlSrwIDL6PW6t3VVGfbYBFp7NvAloc0iU=;
        b=lJi+1y8L83hLCob534tdgkvl+jVbc9POyVzWhnIFz/8N0S5anGQJSOBKHMkebdRrOv
         BZA7N2DJKeL6amB1zk7qT7ODSfqpe/I34p9CRIY8NG8jTpHyMO2qMu1AcnQxZbRV6pHI
         olxOp1EiDv5WMAlz5016PPbgsvr9dR8XNWGusx/kcN6OxXcEvn0J+1mJtrFK4KmJATpj
         JpmiaQ7D6vb2pwoCVs5nnyzAXQTapWaJAoWMjszlsFZD8qwON08IdWJSwwjZqweKb+nI
         Q4N450NGJvRv0lXtXXcrb5rvn0u88LRmWSfypScfnRmVU26Rzf672fPHNURFp9FHiiP+
         7K6g==
X-Gm-Message-State: ANhLgQ29H+aZS+FZIAQch9T5RljZZ15DMGBt4DC2ZozFsKkCP4KdRPlc
        KUDvrxlWcIoEllqqik/pgQyZwXi6rXsn0TRSnkwhBfTj
X-Google-Smtp-Source: ADFU+vtoC47+tQ0c03ehJyLiStK4kkYypznRSFTXRbYuTjHC1n4Sx/iBeZMIroiv6y+aROtKNm0J+zALmkf0dL1qTH0=
X-Received: by 2002:a17:90a:7789:: with SMTP id v9mr202393pjk.29.1584991501748;
 Mon, 23 Mar 2020 12:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200323173653.41305-1-brendanhiggins@google.com>
 <e5f7db19-4468-8679-9ed1-3565a0adcfc0@kernel.org> <CAFd5g46GqBqdrRk6743bnUQyS+yStP3DpkVNWsAMEHDS3i3FBw@mail.gmail.com>
In-Reply-To: <CAFd5g46GqBqdrRk6743bnUQyS+yStP3DpkVNWsAMEHDS3i3FBw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 23 Mar 2020 12:24:50 -0700
Message-ID: <CAFd5g44R6yTQENSsS+LSnQppzO=gDVfPB-TxLn_+aT8UpLiTcQ@mail.gmail.com>
Subject: Re: [PATCH v1] kunit: tool: add missing test data file content
To:     shuah <shuah@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Heidi Fahim <heidifahim@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 12:15 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Mar 23, 2020 at 11:44 AM shuah <shuah@kernel.org> wrote:
> >
> > On 3/23/20 11:36 AM, Brendan Higgins wrote:
> > > A test data file for one of the kunit_tool unit tests was missing; add
> > > it in so that unit tests can run properly.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > > Shuah, this is a fix for a broken test. Can you apply this for 5.7?
> >
> > Can you please add more details on what kind of data this file supplies
> > and which test fails if it doesn't exist.
>
> Sure,
>
> This adds a raw dmesg test log to test the kunit_tool's dmesg parser.
> test_prefix_poundsign and test_output_with_prefix_isolated_correctly
> fail without this test log.
>
> I will send a new revision with this information in the commit message.

I just sent a new revision with an updated message.
