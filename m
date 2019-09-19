Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B9CB76B0
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Sep 2019 11:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388966AbfISJun (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Sep 2019 05:50:43 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:56388 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbfISJum (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Sep 2019 05:50:42 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 1EFC93C0582;
        Thu, 19 Sep 2019 11:50:41 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L6xpfrZ9tsfP; Thu, 19 Sep 2019 11:50:35 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A0C123C057C;
        Thu, 19 Sep 2019 11:50:23 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Thu, 19 Sep
 2019 11:50:23 +0200
Date:   Thu, 19 Sep 2019 11:50:20 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     shuah <shuah@kernel.org>
CC:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jerry Hoemann <jerry.hoemann@hpe.com>,
        Colin Ian King <colin.king@canonical.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] selftests: watchdog: Validate optional file
 argument
Message-ID: <20190919095020.GA15734@vmlxhi-102.adit-jv.com>
References: <20190917184023.16701-1-erosca@de.adit-jv.com>
 <20190918113348.GA23977@vmlxhi-102.adit-jv.com>
 <41ad241a-1c9d-7e20-3cb1-84bf42ec6989@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <41ad241a-1c9d-7e20-3cb1-84bf42ec6989@kernel.org>
User-Agent: Mutt/1.12.1+40 (7f8642d4ee82) (2019-06-28)
X-Originating-IP: [10.72.93.184]
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On Wed, Sep 18, 2019 at 03:05:33PM -0600, Shuah wrote:

[..]

> They both look good to me. I will apply these patches once the merge
> window closes or when my first pull request to Linus clears.
> 
> You will see a notification when I apply them to kselftest tree.

Many thanks for your prompt feedback.

-- 
Best Regards,
Eugeniu
