Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF5FB55A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2019 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfIQSvR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Sep 2019 14:51:17 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:45616 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfIQSvR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Sep 2019 14:51:17 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 78EDA3C04C0;
        Tue, 17 Sep 2019 20:51:15 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y-tpsIf7CpWF; Tue, 17 Sep 2019 20:51:03 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id E33B63C00C4;
        Tue, 17 Sep 2019 20:51:03 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Tue, 17 Sep
 2019 20:51:03 +0200
Date:   Tue, 17 Sep 2019 20:51:00 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     shuah <shuah@kernel.org>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] selftests: watchdog: Validate optional file argument
Message-ID: <20190917185050.GA16818@vmlxhi-102.adit-jv.com>
References: <1568659751-1845-1-git-send-email-george_davis@mentor.com>
 <fa008fd8-f867-b80e-84ed-148e1630c09e@kernel.org>
 <20190917145400.GA14341@vmlxhi-102.adit-jv.com>
 <73bab70b-e22c-42b4-cfca-b4e33431b423@kernel.org>
 <20190917165418.GA21010@vmlxhi-102.adit-jv.com>
 <374127ff-d06f-fcc3-d317-5614dfdc5a71@kernel.org>
 <20190917175056.GA24224@vmlxhi-102.adit-jv.com>
 <2ede1d4d-fa52-2100-2725-1ae32e62a5b6@kernel.org>
 <20190917183246.GB15686@mam-gdavis-lt>
 <20190917184345.GC15686@mam-gdavis-lt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190917184345.GC15686@mam-gdavis-lt>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

(For LKML readability) Superseded by:
 - https://patchwork.kernel.org/patch/11149287/
   ("[v3,1/2] selftests: watchdog: Validate optional file argument")
 - https://patchwork.kernel.org/patch/11149289/
   ("[v3,2/2] selftests: watchdog: Add command line option to show watchdog_info")

-- 
Best Regards,
Eugeniu.
