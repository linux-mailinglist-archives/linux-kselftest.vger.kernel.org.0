Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E1C1CD109
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 May 2020 06:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgEKErW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 May 2020 00:47:22 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55975 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728030AbgEKErV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 May 2020 00:47:21 -0400
X-IronPort-AV: E=Sophos;i="5.73,378,1583164800"; 
   d="scan'208";a="91900972"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 May 2020 12:47:18 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id EE3B24BCC8AE;
        Mon, 11 May 2020 12:47:17 +0800 (CST)
Received: from [10.167.226.45] (10.167.226.45) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Mon, 11 May 2020 12:47:21 +0800
Subject: Re: [PATCH] selftests:mptcp: fix empty optstring
To:     <shuah@kernel.org>
CC:     Li Zhijian <zhijianx.li@intel.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <matthieu.baerts@tessares.net>
References: <20200402065216.23301-1-zhijianx.li@intel.com>
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <4bdd5672-eb24-2e49-e286-702510be0882@cn.fujitsu.com>
Date:   Mon, 11 May 2020 12:47:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200402065216.23301-1-zhijianx.li@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.167.226.45]
X-ClientProxiedBy: G08CNEXCHPEKD04.g08.fujitsu.local (10.167.33.200) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: EE3B24BCC8AE.A1CAF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ping


On 4/2/20 2:52 PM, Li Zhijian wrote:
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>   tools/testing/selftests/net/mptcp/pm_netlink.sh | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> index 9172746b6cf0..8c7998c64d9e 100755
> --- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
> +++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
> @@ -8,8 +8,7 @@ usage() {
>   	echo "Usage: $0 [ -h ]"
>   }
>   
> -
> -while getopts "$optstring" option;do
> +while getopts "h" option;do
>   	case "$option" in
>   	"h")
>   		usage $0



