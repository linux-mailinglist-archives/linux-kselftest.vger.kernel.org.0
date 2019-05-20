Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA922A4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2019 05:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfETDOs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 19 May 2019 23:14:48 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:58066 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728435AbfETDOs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 19 May 2019 23:14:48 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TSB-HBq_1558322084;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TSB-HBq_1558322084)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 20 May 2019 11:14:44 +0800
Subject: Re: [PATCH 1/3] kselftest/cgroup: fix unexcepted testing failure on
 test_memcontrol
To:     Roman Gushchin <guro@fb.com>
Cc:     Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jay Kamat <jgkamat@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cgroups@vger.kernel.org
References: <20190515090704.56929-1-alex.shi@linux.alibaba.com>
 <20190517172930.GA5525@tower.DHCP.thefacebook.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <b2cb203e-e073-b077-94aa-6b6f432b8003@linux.alibaba.com>
Date:   Mon, 20 May 2019 11:14:44 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517172930.GA5525@tower.DHCP.thefacebook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


> Hi Alex!
> 
> Sorry for the late reply, somehow I missed your e-mails.
> 
> The patchset looks good to me, except a typo in subjects/commit logs:
> you probably meant "unexpected failures".
> 
> Please, fix and feel free to use:
> Reviewed-by: Roman Gushchin <guro@fb.com>
> for the series.
> 

Thanks Roman!

BTW, do you know other test cases for cgroup2 function or performance?

Thanks
Alex
