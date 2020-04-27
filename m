Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7201B94C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Apr 2020 02:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgD0Aia (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Apr 2020 20:38:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:9346 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726227AbgD0Aia (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Apr 2020 20:38:30 -0400
X-IronPort-AV: E=Sophos;i="5.73,321,1583164800"; 
   d="scan'208";a="90518240"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Apr 2020 08:38:27 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 44D834BCC8A1;
        Mon, 27 Apr 2020 08:27:46 +0800 (CST)
Received: from localhost.localdomain (10.167.226.81) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 27 Apr 2020 08:38:28 +0800
Subject: Re: About selftests/netfilter failed subtests
To:     Florian Westphal <fw@strlen.de>
CC:     <linux-kselftest@vger.kernel.org>, Philip Li <philip.li@intel.com>,
        Stefano Brivio <sbrivio@redhat.com>
References: <4aa34cdf-2145-01e7-acdf-2fc5d931bbee@cn.fujitsu.com>
 <20200426074529.GG32392@breakpoint.cc>
From:   Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Message-ID: <3646ad42-8b80-eff2-cedc-e04dbaa983c6@cn.fujitsu.com>
Date:   Mon, 27 Apr 2020 08:40:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200426074529.GG32392@breakpoint.cc>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.167.226.81]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 44D834BCC8A1.AADD1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: liuyd.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Very appericate it !

On 4/26/20 3:45 PM, Florian Westphal wrote:
> Liu Yiding <liuyd.fnst@cn.fujitsu.com> wrote:
>> Hi, all.
>>
>> Our team works on testing kernel commit and reporting regression.
>>
>> Tool selftests is important to us.
>>
>> Recently i enabled netfilter in out testing env, i met below failed
>> subtests.
>>
>> ```
>>
>>    "kernel-selftests.netfilter.nft_nat.sh.fail": [
>> "kernel-selftests.netfilter.conntrack_icmp_related.sh.fail": [
>>    "kernel-selftests.netfilter.nft_flowtable.sh.fail": [
>>    "kernel-selftests.netfilter.nft_concat_range.sh.fail": [
>>
>> ```
>>
>> Our testing env:
>>
>>
>> It looks that i missed some modules or i get wrong config of nftables. I had
>> opend kconfig mentioned in netfilter/config.
> Maybe its incomplete. From a quick glance, all of these should be on:
>
> # CONFIG_NFT_OBJREF is not set
> # CONFIG_NFT_NAT is not set
> # CONFIG_NF_FLOW_TABLE is not set
> # CONFIG_NF_TABLES_NETDEV is not set
>
>
>
-- 
Best Regards.
Liu Yiding



