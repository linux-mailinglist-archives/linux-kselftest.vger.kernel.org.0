Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D47B55B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 20:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfIQSx6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 14:53:58 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45631 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfIQSx6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 14:53:58 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 571A83C04C0;
        Tue, 17 Sep 2019 20:53:56 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vo3uoP3tC-mn; Tue, 17 Sep 2019 20:53:50 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id ECEC63C00C4;
        Tue, 17 Sep 2019 20:53:50 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Sep
 2019 20:53:50 +0200
Date:   Tue, 17 Sep 2019 20:53:50 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     "George G. Davis" <george_davis@mentor.com>,
        shuah <shuah@kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests: watchdog: Add command line option to show
 watchdog_info
Message-ID: <20190917185350.GB16818@vmlxhi-102.adit-jv.com>
References: <20190907085833.21167-1-erosca@de.adit-jv.com>
 <20190907085833.21167-2-erosca@de.adit-jv.com>
 <2b08fa83-185b-4eb7-1217-37ed31d810b5@kernel.org>
 <20190916135756.GA24319@vmlxhi-102.adit-jv.com>
 <24cc0dde-6df3-3ea2-3e1d-0bc166bb48ac@kernel.org>
 <20190916161541.GB19227@mam-gdavis-lt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190916161541.GB19227@mam-gdavis-lt>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

(For LKML readability) Superseded by:
 - https://patchwork.kernel.org/patch/11149289/
   ("[v3,2/2] selftests: watchdog: Add command line option to show watchdog_info")

-- 
Best Regards,
Eugeniu.
