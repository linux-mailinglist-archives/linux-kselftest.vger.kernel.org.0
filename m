Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA5A2A1FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2019 02:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfEYAGl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 20:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfEYAGl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 20:06:41 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F5C2075E;
        Sat, 25 May 2019 00:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558742800;
        bh=R5AKhhljVFaewfHEJrRuX+cMSqD/1Iy0pRTZaZD5wOA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gCiElU+nd/lFG9ym/Rld6sfSG6dgF4ypBbDXnsWuBOAJPxmOH5Ruw1x0wSNYyzIkd
         gqUvYt2Y1Hy9DiuXT88sEqhkTCfDgtxngUDv7/Zax9v7o/YFOOvrbPtp66lSut0EWI
         t6IPvgPj2T76F4J4cGrkn+8xspQXslqqsQa5l2hI=
Subject: Re: [PATCH v2 1/3] kselftest/cgroup: fix unexpected testing failure
 on test_memcontrol
To:     Tejun Heo <tj@kernel.org>, Alex Shi <alex.shi@linux.alibaba.com>
Cc:     cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jay Kamat <jgkamat@fb.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, shuah <shuah@kernel.org>
References: <20190520030140.203605-1-alex.shi@linux.alibaba.com>
 <20190520030140.203605-2-alex.shi@linux.alibaba.com>
 <20190524214035.GG374014@devbig004.ftw2.facebook.com>
 <0c6b76b8-e20c-33f0-21da-64a5d5da30a9@kernel.org>
From:   shuah <shuah@kernel.org>
Message-ID: <ea5514c1-80a1-3c41-de1c-43582b6f1a49@kernel.org>
Date:   Fri, 24 May 2019 18:06:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0c6b76b8-e20c-33f0-21da-64a5d5da30a9@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/24/19 3:44 PM, shuah wrote:
> On 5/24/19 3:40 PM, Tejun Heo wrote:
>> Hello,
>>
>> All three patches look good to me.  Please feel free to add my
>> acked-by.  Shuah, should I route these through cgroup tree or would
>> the kselftest tree be a better fit?
>>
>> Thanks.
>>
> 
> 
> Tejun, I can take them through kselftest tree.
> 

Alex,

patches 1/3 and 2/3 failed checkpatch. Could you please the warns
and send v3. Go ahead and send all v3 for all 3 patches

thanks,
-- Shuah

