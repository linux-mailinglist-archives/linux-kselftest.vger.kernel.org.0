Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A89A0A3F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 21:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfH1TR6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 15:17:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfH1TR6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 15:17:58 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9A56214DA;
        Wed, 28 Aug 2019 19:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567019877;
        bh=JzG+dAL9CutFkCeaKxXi8FmvgK4eO6VPyeCKPmIpZNA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hu/9hmn8Uytf9xJVkeHKHLxAvPP0sIw7IeW28Isam5+nMmPOUUo2BBiKcBtd2C4Tf
         SsHIj+LggPH5MA/F+/h4W4SDQA2A7JSyrI2p1OYza6D/520xbhsKyPNo6N4zhSoAD3
         04NXlSn3W+s274z++3shcmJf//ZxLE2/AK71yJaI=
Subject: Re: [PATCH v2] doc: kselftest: update for clarity on running
 kselftests in CI rings
To:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.rue@linaro.org,
        anders.roxell@linaro.org, shuah <shuah@kernel.org>
References: <20190827003709.26950-1-skhan@linuxfoundation.org>
From:   shuah <shuah@kernel.org>
Message-ID: <f5088365-68a1-6036-0037-b6e9af01391f@kernel.org>
Date:   Wed, 28 Aug 2019 13:17:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827003709.26950-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/26/19 6:37 PM, Shuah Khan wrote:
> Update to add clarity and recommendations on running newer kselftests
> on older kernels vs. matching the kernel and kselftest revisions.
> 
> The recommendation is "Match kernel revision and kselftest."
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1: Fixed "WARNING: Title underline too short."

I have a few more changes and would like to make and send a v3 after
the LPC's Testing and Fuzzing kselftest discussion.

Holding off on this patch for now.

thanks,
-- Shuah
