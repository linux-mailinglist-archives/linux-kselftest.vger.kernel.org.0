Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 579C473208
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfGXOqB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 10:46:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfGXOqB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 10:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RqHBWdJEojbFEMOHR/DJK74bidFUULY+xJTZc/lCv10=; b=ZAfomt8Um8SI+7YgXhUbnm3PY
        RTXHQBkPZP43/E42xA+eQuJIa4WO4M8/2gRLN+JsHXKijRXoh4Sz25H3FeYmDzWhNAvGhID0qYBWS
        hI53DddFv39a9Hg8h+6JphiV4sL2rakxmMgA645hzx5chjXUrBUZQsfG1IM6l8/hVdAPaSY4z9Opw
        0E/mCCHVl+CzCUb+uDzwJ9clmefeXZBgMD1wCgpY39DyuCDMf8IMUCcc1qxDX/fsyUZMuvZcdlj3k
        FrSQ6htBN27JBeZF4MuEJq/fG8NsW5M+Go0jP7Q/UjCA7bHszrQSH1SaAIjgWqLVDZ1xgqcIButxN
        joinlt3ZQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.17])
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hqIWm-0002bd-OJ; Wed, 24 Jul 2019 14:46:00 +0000
Subject: Re: [PATCH] selftests: mlxsw: Fix typo in qos_mc_aware.sh
To:     Masanari Iida <standby24x7@gmail.com>, shuah@kernel.org,
        linux-kernel@vger.kernel.org, jiri@mellanox.com,
        idosch@mellanox.com, linux-kselftest@vger.kernel.org
References: <20190724141554.31723-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3a7ae37c-36b8-74bb-4537-c87cee8ea410@infradead.org>
Date:   Wed, 24 Jul 2019 07:45:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190724141554.31723-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/24/19 7:15 AM, Masanari Iida wrote:
> This patch fixes some spelling typo in qos_mc_aware.sh
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
> index 71231ad2dbfb..47315fe48d5a 100755
> --- a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
> +++ b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
> @@ -262,7 +262,7 @@ test_mc_aware()
>  
>  	stop_traffic
>  
> -	log_test "UC performace under MC overload"
> +	log_test "UC performance under MC overload"
>  
>  	echo "UC-only throughput  $(humanize $ucth1)"
>  	echo "UC+MC throughput    $(humanize $ucth2)"
> @@ -316,7 +316,7 @@ test_uc_aware()
>  
>  	stop_traffic
>  
> -	log_test "MC performace under UC overload"
> +	log_test "MC performance under UC overload"
>  	echo "    ingress UC throughput $(humanize ${uc_ir})"
>  	echo "    egress UC throughput  $(humanize ${uc_er})"
>  	echo "    sent $attempts BC ARPs, got $passes responses"
> 


-- 
~Randy
