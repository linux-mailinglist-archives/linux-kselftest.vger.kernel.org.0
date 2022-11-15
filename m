Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48A362A2B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKOUW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 15:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiKOUW2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 15:22:28 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1323F2CE29;
        Tue, 15 Nov 2022 12:22:26 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D6BE6240008;
        Tue, 15 Nov 2022 20:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668543745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edBFNj3x//5c8HYKW61vT0cJo+fs1rPkH5Qkqr/2Tiw=;
        b=WdNGNACyNHXnHrqZNnplP/JgLSnL61JYDshgq+PieIbIpAAju5TY+DFzsVajAMjVBQobve
        q18LRo41GgRajc8VUVsnqAANVD+FfIokMXyUYYrvGMkWmKdr4yPZfyeLsHMTgO7FZmXR/V
        XNZHmpU5eUKcDwMGwe9/4TkP5axgx/9INk2L/mXtSTUvsQrFiW7DLN5dSjVLWWTuj2sgdT
        hj5csKYpM5QNfJW8xQb/OEak7hjUbU3MVYvaozZLJc7TSwPkT+zyVKC96nOMJcPQ0q8eQy
        aVS85OvPM/pjz3S6iFmy8/eCFkpcK4onTxtXWPuTYWiseDctzKeGVqNF23I2jg==
Date:   Tue, 15 Nov 2022 21:22:24 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Shuah Khan <shuah@kernel.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: rtc: skip when RTC is not present
Message-ID: <Y3P1AK+BgnEDwEA4@mail.local>
References: <20221115200422.2306194-1-alexandre.belloni@bootlin.com>
 <7b864479-e7c6-cabe-e363-a8268f7ce2f2@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b864479-e7c6-cabe-e363-a8268f7ce2f2@linuxfoundation.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 15/11/2022 13:10:45-0700, Shuah Khan wrote:
> On 11/15/22 13:04, alexandre.belloni@bootlin.com wrote:
> > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > 
> > There is not point in failing the tests when there the RTC is not present,
> > simply skip the test.
> > 
> Could be rephrased to read:
> 
> There is no point in failing the tests when RTC is not present.
> 
> I can fix them when I apply the patch or send me v2

Sorry, I wrote that quickly a few days ago and didn't check again. v2 is
sent.

> 
> 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Tested-by:  Daniel Diaz <daniel.diaz@linaro.org>
> > ---
> 
> thanks,
> -- Shuah
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
