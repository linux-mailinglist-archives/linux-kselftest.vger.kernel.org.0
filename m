Return-Path: <linux-kselftest+bounces-26109-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944BA2D805
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 19:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9FD1888078
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Feb 2025 18:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E937E1F30C7;
	Sat,  8 Feb 2025 18:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hMfsMX/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F581714AC;
	Sat,  8 Feb 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739039209; cv=none; b=UBnfnp7EQBXml2LDKsFyukhhhB52IeFiUUSgldnbtmkQs0RN+WJp9rAFRLqf0H8smDGzf+XTcrgBcbDKML4fMZxqMKVl7OT8hrJZVZwtx7pnpx8BPVYxj0/6RSukTXZjZFQx+NDQiqhFCLcuVUrdu/D3VczydiiUCiPuTBFeWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739039209; c=relaxed/simple;
	bh=9vDK68QQZRosnkDe9Vqw2x9gXKsq56LrqlcltzABfh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBmdCgTVYHxLPsj4b4SsCcGl8cY5jcwaJmkRPvvyCYbbMFRpF23/j5452BwZbOnJQj3+3khGZrv/FF4u3h0ZIP45EjFRrif3+bOhCkskS1vlSpIeN3aIZf7XgPIf1bU0C71/ASBr1+H+7C7kZcJOqNNHHtadWV9UtHa2c1wIMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hMfsMX/2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739039208; x=1770575208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9vDK68QQZRosnkDe9Vqw2x9gXKsq56LrqlcltzABfh8=;
  b=hMfsMX/2c5iUcLCqAvixZmoSXlcXkKL8Nxl4X/x97CvbOhjlaaC/ra+1
   O23X/LTFvOZO7ATuU3mCTx8gBNJAHG43LMjJQjmbzuBZ94xSEwVmvyYdD
   7NfQl3J7h3Z8ZpR10hkb5B/4P58DaXX6V7NtuR6JqpUWBLnYOdPFi59xu
   v64/M3mevZqRKEh8u7MbY6Z5msZmAncW9eix5MxFhhUfmVcZ8tXgOW7p/
   7UGnaifdt6vjfj0mZNp4RdrDXWOEpAxtecPHiRwR/bBBZrDIKC/uR35Ca
   kv1uE5hmoabgNlzRPamndVlOzqR8tMD2m8PqgMr72nC8w2eDBHqA7QVvD
   Q==;
X-CSE-ConnectionGUID: K+5Q//IaTwicM0FxtDo4sQ==
X-CSE-MsgGUID: iRmcHAtuQkq9VnM4qGpeGg==
X-IronPort-AV: E=McAfee;i="6700,10204,11339"; a="39555055"
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="39555055"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 10:26:47 -0800
X-CSE-ConnectionGUID: v2y3OrLBSIu7EbdKo51wjA==
X-CSE-MsgGUID: LgCKuGihQye7mE4+/uUxZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,270,1732608000"; 
   d="scan'208";a="142677431"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 Feb 2025 10:26:42 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgpXL-0010UZ-2B;
	Sat, 08 Feb 2025 18:26:39 +0000
Date: Sun, 9 Feb 2025 02:26:27 +0800
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
Message-ID: <202502090248.Ed6S8p8J-lkp@intel.com>
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
config: riscv-randconfig-r123-20250208 (https://download.01.org/0day-ci/archive/20250209/202502090248.Ed6S8p8J-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.2.0
reproduce: (https://download.01.org/0day-ci/archive/20250209/202502090248.Ed6S8p8J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502090248.Ed6S8p8J-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> lib/blackhole_dev_kunit.c:55:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] payload_len @@     got unsigned long @@
   lib/blackhole_dev_kunit.c:55:27: sparse:     expected restricted __be16 [usertype] payload_len
   lib/blackhole_dev_kunit.c:55:27: sparse:     got unsigned long

vim +55 lib/blackhole_dev_kunit.c

509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  26  
a644885645ce867 lib/blackhole_dev_kunit.c Tamir Duberstein 2025-02-07  27  static void test_blackholedev(struct kunit *test)
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  28  {
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  29  	struct ipv6hdr *ip6h;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  30  	struct sk_buff *skb;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  31  	struct udphdr *uh;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  32  	int data_len;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  33  
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  34  	skb = alloc_skb(SKB_SIZE, GFP_KERNEL);
a644885645ce867 lib/blackhole_dev_kunit.c Tamir Duberstein 2025-02-07  35  	KUNIT_ASSERT_NOT_NULL(test, skb);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  36  
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  37  	/* Reserve head-room for the headers */
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  38  	skb_reserve(skb, HEAD_SIZE);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  39  
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  40  	/* Add data to the skb */
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  41  	data_len = SKB_SIZE - (HEAD_SIZE + TAIL_SIZE);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  42  	memset(__skb_put(skb, data_len), 0xf, data_len);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  43  
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  44  	/* Add protocol data */
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  45  	/* (Transport) UDP */
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  46  	uh = (struct udphdr *)skb_push(skb, sizeof(struct udphdr));
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  47  	skb_set_transport_header(skb, 0);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  48  	uh->source = uh->dest = htons(UDP_PORT);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  49  	uh->len = htons(data_len);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  50  	uh->check = 0;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  51  	/* (Network) IPv6 */
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  52  	ip6h = (struct ipv6hdr *)skb_push(skb, sizeof(struct ipv6hdr));
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  53  	skb_set_network_header(skb, 0);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  54  	ip6h->hop_limit = 32;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01 @55  	ip6h->payload_len = data_len + sizeof(struct udphdr);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  56  	ip6h->nexthdr = IPPROTO_UDP;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  57  	ip6h->saddr = in6addr_loopback;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  58  	ip6h->daddr = in6addr_loopback;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  59  	/* Ether */
843a8851e89e2e8 lib/test_blackhole_dev.c  Breno Leitao     2024-02-02  60  	skb_push(skb, sizeof(struct ethhdr));
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  61  	skb_set_mac_header(skb, 0);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  62  
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  63  	skb->protocol = htons(ETH_P_IPV6);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  64  	skb->pkt_type = PACKET_HOST;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  65  	skb->dev = blackhole_netdev;
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  66  
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  67  	/* Now attempt to send the packet */
a644885645ce867 lib/blackhole_dev_kunit.c Tamir Duberstein 2025-02-07  68  	KUNIT_EXPECT_EQ(test, dev_queue_xmit(skb), NET_XMIT_SUCCESS);
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  69  }
509e56b37cc32c9 lib/test_blackhole_dev.c  Mahesh Bandewar  2019-07-01  70  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

