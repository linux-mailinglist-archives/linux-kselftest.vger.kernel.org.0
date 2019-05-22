Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAE4265BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2019 16:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfEVOaa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 May 2019 10:30:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41583 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbfEVOaa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 May 2019 10:30:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id f12so1167375plt.8
        for <linux-kselftest@vger.kernel.org>; Wed, 22 May 2019 07:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0m0QjYyjO2xHrKzFzTehhWEPphtJIzzFFRYPzTW3DMQ=;
        b=T2kYxw6M4VFwvrSg9HRUF2uPooKZ2Dk6AmNuLHygKvbtjUp1C79ABGleU4NpWQgtG+
         xyNerFhZb1XMy6mw5lQzehrEE7/NBqYQPzUt9jvyTeLj9vsYw3pAry+y23L3yjfCjhDJ
         yoMBcgsNSAsgypmbF99mRLSytz+s/UDYzeuQUPzFC6WTuCtGRKRYUgQx6yvSE/FxlWH2
         pqRUDuI5S4wSMke309nhIOWTIHwzEzKiKdSXZRidURLm26VHEBEOC1iIc3U2gexz0ynG
         vOxHFexpwwsDmgzyeSI00gmNJ0WAnYhTVwEa0K2+6EZjiULYXI9ZcdenQdTGsT3HwctH
         k3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0m0QjYyjO2xHrKzFzTehhWEPphtJIzzFFRYPzTW3DMQ=;
        b=CWGuPwXUt9rmou0Revcw1YarPk70AH0Mu6kYK1/SWQZFc/JZ6Fht0Aez3fWs2YqV85
         FBt73d3HWlUoi48pDCRT9wuUFLCcuMzhMo08cq3eTQRaYzCli/iP7J825di2Iog6BPw4
         dbY9Rvq2RVwa+nYkacqAUHXB7NBUWQNMUZe4aPrQnnUHoMpLyIDdCeqWm6HiGG09iMwJ
         GXDthGBYwe0d/jrBoMWb5ZdWJzcW2gZCFsL6W/jPcZYEtlhK/QJgy6vqnUyX7gDj1woU
         BDAl36aoATuHdqiRP0zmkDFNW3NsWdufIAftooMDAJ7iqQnV8S9Jv8N3P1slioMkFTsk
         NxAg==
X-Gm-Message-State: APjAAAXsPdTflyxz/FaxlUGXlsHk8U6v046RISt/sgJotUNEfD7smDpV
        aBLfPxFXP8GO/jIpc0jR+K0RJJ9GCkm6t2WdYwZaag==
X-Google-Smtp-Source: APXvYqxvo1fFJOMp10yWhcwkQF+EVwPZOIUCu4QXMKCMejzytyZV3guibp+FcWp+LRDJRt9vDpZ3/2/a9GARbq9GNuo=
X-Received: by 2002:a17:902:3103:: with SMTP id w3mr15769604plb.187.1558535429532;
 Wed, 22 May 2019 07:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190515064405.3981-1-jeffrin@rajagiritech.edu.in> <20190521181125.anqj32v3gcwjxs3z@salvia>
In-Reply-To: <20190521181125.anqj32v3gcwjxs3z@salvia>
From:   Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date:   Wed, 22 May 2019 19:59:53 +0530
Message-ID: <CAG=yYwkAUzGZWdVpcjRScARyOyO9KaTCL_7LUxaav5os+6rsEA@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: netfilter: missing error check when setting
 up veth interface
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks to all !

On Tue, May 21, 2019 at 11:41 PM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>
> On Wed, May 15, 2019 at 12:14:04PM +0530, Jeffrin Jose T wrote:
> > A test for  the basic NAT functionality uses ip command which
> > needs veth device.There is a condition where the kernel support
> > for veth is not compiled into the kernel and the test script
> > breaks.This patch contains code for reasonable error display
> > and correct code exit.
>
> Applied, thanks.



-- 
software engineer
rajagiri school of engineering and technology
