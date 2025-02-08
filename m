Return-Path: <linux-kselftest+bounces-26110-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A763A2D808
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 19:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13C07166B5F
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57D31974FE;
	Sat,  8 Feb 2025 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMeK9eeu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2E5241135;
	Sat,  8 Feb 2025 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739039869; cv=none; b=coNEDsynzz2L0/b46Ikk/d9EPVgim+97IenEUej6/TCLk9YLz7WNqk+GAWbeVVUfcqhCcGhf/OZU1266R5D5U0KHHJLXAKoZh3OfVcIuQIi5VuTsrtpPn9spGSL9hAx5fD6yJ0zXtkXVoRcNxRoWQ0INf4Vkdj6UeS4+cWaTpAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739039869; c=relaxed/simple;
	bh=OiPh1lu4rx22B7KSumWl+7P7nOfgNMfxfiVWxLMUgfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIofEOo5r0ip5+uaxvXZjoRkX+ACsD3b7bSXUvnqe6AEEMTwX5ChxNXb+JLvUGrCkZKLGpjp8yO+gxFs5nboZ4vNBHTMoy8yXLHuJiuwKFApe5jUoOZvd2yMxb/4pLVhjIVkY4CdN/dFDN0eteIjEb5iMQ8V8zx7pGQZ5/4nSLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMeK9eeu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739039868; x=1770575868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OiPh1lu4rx22B7KSumWl+7P7nOfgNMfxfiVWxLMUgfo=;
  b=JMeK9eeuM0uTs6p5f+k/iLBWybKeqGegd1vl5E218jcC4fgbvWjaPEw3
   6qQUy0pKutlkmqEC8fmILIYYe9J9vQP6RUB/c7in4AbNXprkEsBC3UkI4
   gSbNgU5A51yUq1iKfnRqApeZVAuUl5dwRurrEMF8amZlhvIwNIwZ8lv4R
   AvCgtYC4oWDpmgnySGZFu1+0qK6/ev8wYW4J78w3uwaDaFkfZa/SSooEA
   OYw+Jh3s3QIWcKFOXnsFRVlMmwwY07Rn80yIZZ38g8pHdAyii8qfoN0uc
   IIAvLfQrGShYCfZ/WNu9k9UIKJGsMJKlil/mNCrLvj2dApvfmjn0BtXMr
   w==;
X-CSE-ConnectionGUID: 9oXdIVUrQ+Cqzn+OHV6DBA==
X-CSE-MsgGUID: hwah6nS7S5mkP0fzLTDKsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="39555627"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="39555627"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 10:37:47 -0800
X-CSE-ConnectionGUID: ZUCm+zcCTCSDgP0A12ya5Q==
X-CSE-MsgGUID: hRILAmttT0GVWW/cfCbPkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="112441264"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Feb 2025 10:37:43 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgpi0-0010V9-2U;
	Sat, 08 Feb 2025 18:37:40 +0000
Date: Sun, 9 Feb 2025 02:36:40 +0800
From: kernel test robot <lkp@intel.com>
To: Tamir Duberstein <tamird@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH] blackhole_dev: convert self-test to KUnit
Message-ID: <202502090223.qCYMBjWT-lkp@intel.com>
References: <20250207-blackholedev-kunit-convert-v1-1-8ef0dc1ff881@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-blackholedev-kunit-convert-v1-1-8ef0dc1ff881@gmail.com>

Hi Tamir,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2014c95afecee3e76ca4a56956a936e23283f05b]

url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/blackhole_dev-convert-self-test-to-KUnit/20250208-074037
base:   2014c95afecee3e76ca4a56956a936e23283f05b
patch link:    https://lore.kernel.org/r/20250207-blackholedev-kunit-convert-v1-1-8ef0dc1ff881%40gmail.com
patch subject: [PATCH] blackhole_dev: convert self-test to KUnit
config: i386-randconfig-062-20250208 (https://download.01.org/0day-ci/archive/20250209/202502090223.qCYMBjWT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250209/202502090223.qCYMBjWT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502090223.qCYMBjWT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/blackhole_dev_kunit.c:55:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] payload_len @@     got unsigned int @@
   lib/blackhole_dev_kunit.c:55:27: sparse:     expected restricted __be16 [usertype] payload_len
   lib/blackhole_dev_kunit.c:55:27: sparse:     got unsigned int

vim +55 lib/blackhole_dev_kunit.c

509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  26  
a644885645ce86 lib/blackhole_dev_kunit.c Tamir Duberstein 2025-02-07  27  static void test_blackholedev(struct kunit *test)
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  28  {
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  29  	struct ipv6hdr *ip6h;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  30  	struct sk_buff *skb;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  31  	struct udphdr *uh;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  32  	int data_len;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  33  
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  34  	skb = alloc_skb(SKB_SIZE, GFP_KERNEL);
a644885645ce86 lib/blackhole_dev_kunit.c Tamir Duberstein 2025-02-07  35  	KUNIT_ASSERT_NOT_NULL(test, skb);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  36  
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  37  	/* Reserve head-room for the headers */
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  38  	skb_reserve(skb, HEAD_SIZE);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  39  
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  40  	/* Add data to the skb */
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  41  	data_len = SKB_SIZE - (HEAD_SIZE + TAIL_SIZE);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  42  	memset(__skb_put(skb, data_len), 0xf, data_len);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  43  
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  44  	/* Add protocol data */
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  45  	/* (Transport) UDP */
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  46  	uh = (struct udphdr *)skb_push(skb, sizeof(struct udphdr));
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  47  	skb_set_transport_header(skb, 0);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  48  	uh->source = uh->dest = htons(UDP_PORT);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  49  	uh->len = htons(data_len);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  50  	uh->check = 0;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  51  	/* (Network) IPv6 */
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  52  	ip6h = (struct ipv6hdr *)skb_push(skb, sizeof(struct ipv6hdr));
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  53  	skb_set_network_header(skb, 0);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  54  	ip6h->hop_limit = 32;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01 @55  	ip6h->payload_len = data_len + sizeof(struct udphdr);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  56  	ip6h->nexthdr = IPPROTO_UDP;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  57  	ip6h->saddr = in6addr_loopback;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  58  	ip6h->daddr = in6addr_loopback;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  59  	/* Ether */
843a8851e89e2e lib/test_blackhole_dev.c  Breno Leitao     2024-02-02  60  	skb_push(skb, sizeof(struct ethhdr));
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  61  	skb_set_mac_header(skb, 0);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  62  
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  63  	skb->protocol = htons(ETH_P_IPV6);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  64  	skb->pkt_type = PACKET_HOST;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  65  	skb->dev = blackhole_netdev;
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  66  
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  67  	/* Now attempt to send the packet */
a644885645ce86 lib/blackhole_dev_kunit.c Tamir Duberstein 2025-02-07  68  	KUNIT_EXPECT_EQ(test, dev_queue_xmit(skb), NET_XMIT_SUCCESS);
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  69  }
509e56b37cc32c lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  70  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

