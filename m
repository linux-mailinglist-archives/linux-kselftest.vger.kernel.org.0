Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307321B8D9C
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Apr 2020 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgDZHpi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 26 Apr 2020 03:45:38 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:39828 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726110AbgDZHpi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 26 Apr 2020 03:45:38 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jSbyj-00035i-Tw; Sun, 26 Apr 2020 09:45:30 +0200
Date:   Sun, 26 Apr 2020 09:45:29 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Cc:     linux-kselftest@vger.kernel.org, Philip Li <philip.li@intel.com>,
        Florian Westphal <fw@strlen.de>,
        Stefano Brivio <sbrivio@redhat.com>
Subject: Re: About selftests/netfilter failed subtests
Message-ID: <20200426074529.GG32392@breakpoint.cc>
References: <4aa34cdf-2145-01e7-acdf-2fc5d931bbee@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aa34cdf-2145-01e7-acdf-2fc5d931bbee@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Liu Yiding <liuyd.fnst@cn.fujitsu.com> wrote:
> Hi, all.
> 
> Our team works on testing kernel commit and reporting regression.
> 
> Tool selftests is important to us.
> 
> Recently i enabled netfilter in out testing env, i met below failed
> subtests.
> 
> ```
> 
>   "kernel-selftests.netfilter.nft_nat.sh.fail": [
> "kernel-selftests.netfilter.conntrack_icmp_related.sh.fail": [
>   "kernel-selftests.netfilter.nft_flowtable.sh.fail": [
>   "kernel-selftests.netfilter.nft_concat_range.sh.fail": [
> 
> ```
> 
> Our testing env:
> 
> 
> It looks that i missed some modules or i get wrong config of nftables. I had
> opend kconfig mentioned in netfilter/config.

Maybe its incomplete. From a quick glance, all of these should be on:

# CONFIG_NFT_OBJREF is not set
# CONFIG_NFT_NAT is not set
# CONFIG_NF_FLOW_TABLE is not set
# CONFIG_NF_TABLES_NETDEV is not set

