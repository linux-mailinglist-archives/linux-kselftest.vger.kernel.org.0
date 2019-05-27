Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C60082AEB9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 May 2019 08:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfE0Gax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 May 2019 02:30:53 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:41793 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbfE0Gax (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 May 2019 02:30:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TSmsaCE_1558938633;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TSmsaCE_1558938633)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 May 2019 14:30:34 +0800
Subject: Re: [PATCH v2 1/3] kselftest/cgroup: fix unexpected testing failure
 on test_memcontrol
To:     shuah <shuah@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jay Kamat <jgkamat@fb.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190520030140.203605-1-alex.shi@linux.alibaba.com>
 <20190520030140.203605-2-alex.shi@linux.alibaba.com>
 <20190524214035.GG374014@devbig004.ftw2.facebook.com>
 <0c6b76b8-e20c-33f0-21da-64a5d5da30a9@kernel.org>
 <ea5514c1-80a1-3c41-de1c-43582b6f1a49@kernel.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <3db110a3-0662-24ae-ef0a-cde3deee99ea@linux.alibaba.com>
Date:   Mon, 27 May 2019 14:30:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ea5514c1-80a1-3c41-de1c-43582b6f1a49@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 2019/5/25 8:06 上午, shuah wrote:
> Alex,
> 
> patches 1/3 and 2/3 failed checkpatch. Could you please the warns
> and send v3. Go ahead and send all v3 for all 3 patches

fixed and rent. 

Thanks a lot! 
Alex 
