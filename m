Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260C9739542
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 04:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjFVCJa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 22:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjFVCJ3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 22:09:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95449AC;
        Wed, 21 Jun 2023 19:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Jh+sIBjTdpmN4bUdroe5Mom352UKBoihFU0ru+h1MFo=; b=ZnGaFtAYOb+yMjydAZycuQNc1U
        Zc4s8vsOkWTz+/q7mdsTMXCu71SKCsIO2C4RRIK9Jqb8h6H9wc+Y/8ZVCdhYcy4rHFr5CWT6BhFmc
        HnNoX4D+KWjgPf6r5FY8rX7JGdvUE4dgRR9bzvS8OKD2hVn6PeqmMCpW7WhtI3HAeS7EqsIYH9qv8
        6fnxNk1UUA7f92Ik2vFbd7Fsu+OL4K1FL30ECew9m11Y4NDPUSxeFsAAP8jUZsY+yFFcD2X+xU3rY
        /MCLzV9g7CsJrEyPZwt5r7y4xWa+nkaz78HRCGGdiGeuqL46/HppiVpnxNErSXh0Q11CjH/3wEl4N
        H3rScSlA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC9l6-00GWGA-0w;
        Thu, 22 Jun 2023 02:09:16 +0000
Message-ID: <9860cb6c-8fd4-79c6-a64b-ea855298e339@infradead.org>
Date:   Wed, 21 Jun 2023 19:09:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 8/8] scripts/spelling.txt: Add "transmit" patterns
Content-Language: en-US
To:     Yueh-Shun Li <shamrocklee@posteo.net>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622012627.15050-1-shamrocklee@posteo.net>
 <20230622012627.15050-9-shamrocklee@posteo.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230622012627.15050-9-shamrocklee@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 6/21/23 18:26, Yueh-Shun Li wrote:
> Add "transmit"-related patterns misspelled with the first "s" missing.
> 
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  scripts/spelling.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index f8bd6178d17b..c81e489ba4cf 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -1319,6 +1319,12 @@ ressource||resource
>  ressources||resources
>  restesting||retesting
>  resumbmitting||resubmitting
> +retranmission||retransmission
> +retranmissions||retransmissions
> +retranmit||retransmit
> +retranmits||retransmits
> +retranmitted||retransmitted
> +retranmitting||retransmitting
>  retransmited||retransmitted
>  retreived||retrieved
>  retreive||retrieve
> @@ -1553,6 +1559,11 @@ tranasction||transaction
>  tranceiver||transceiver
>  tranfer||transfer
>  tranmission||transmission
> +tranmissions||transmissions
> +tranmit||transmit
> +tranmits||transmits
> +tranmitted||transmitted
> +tranmitting||transmitting
>  transcevier||transceiver
>  transciever||transceiver
>  transferd||transferred

-- 
~Randy
