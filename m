Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 877362A094
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2019 23:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404259AbfEXVoG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 May 2019 17:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404176AbfEXVoG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 May 2019 17:44:06 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA61217D7;
        Fri, 24 May 2019 21:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558734246;
        bh=TiUA1WFEq7Il0rd+tzTv7rHfLDePXM5hZjMGD293VfM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cJ+pF9asSBVEbeEPeP4pGA0GV5iHC4bFiFHmwoUEDwMg7DFd9qo4/LIbkBQ4tMJEI
         0P7Xi2JdoC42bXYGpT6WKBUWfmkp7AZszIPijW/GZ8fpUAlM95SC/uT8XAKkzXDsjB
         MsQHY6yNf8WuMRRrrmjS3ZtdwpvPrvdw9ldaJSyY=
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
From:   shuah <shuah@kernel.org>
Message-ID: <0c6b76b8-e20c-33f0-21da-64a5d5da30a9@kernel.org>
Date:   Fri, 24 May 2019 15:44:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524214035.GG374014@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/24/19 3:40 PM, Tejun Heo wrote:
> Hello,
> 
> All three patches look good to me.  Please feel free to add my
> acked-by.  Shuah, should I route these through cgroup tree or would
> the kselftest tree be a better fit?
> 
> Thanks.
> 


Tejun, I can take them through kselftest tree.

thanks,
-- Shuah
