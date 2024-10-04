Return-Path: <linux-kselftest+bounces-19069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A07991024
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 22:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8681F2747F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 20:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F261DD9C8;
	Fri,  4 Oct 2024 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="anUMBa7m";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="D611fMmw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14851DD887
	for <linux-kselftest@vger.kernel.org>; Fri,  4 Oct 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072041; cv=none; b=m6CFTGHoIduoi8MTqFNXamplSC1HcGMgIx3WTUb80Cez5d+cKvPYl22d9/7WXVM1k7cPK0qnz1YZ81ZnfW6l/9uaLyhsYACyGpJRRSerLNLfWQHXqwn9UeV9Pm3HD2y8fDlCRQSY58/JewK1zbs1jQU3eXy3vLz8Oqn9zaLlp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072041; c=relaxed/simple;
	bh=ekDVyd3HSW+N9GGe5wx6qgFGUh9DrSzRbbdlNF11H4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAHT2PYSmP904eQ7nyJA8wAkW7eX8GxQ4eXf0VlLUk32xIZCv0X/SUliaqTS3RbcnB5w0v2PBX4Vybx2aFOn4sgnZahFr2NoDA7CQdIgPTYPBmOixuh3pN1H2xas/Df03zHim6fFxlVPuJXaMfPPGUzhw4PBR/zA3oOdpbjYm8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=anUMBa7m; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=D611fMmw; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=anUMBa7miv2KnYlo9FugDs76NEAcaNgSgg4eueR2Pq2z53fDGz+QPAmvkkj8Y0QVkLCoFryqNrSAviLLoIOwhLxzY6soStO2/CV5nZq6gS7vv5sXYO06iOeHylKl4vG3f24SEzR3irbLv3kfQYBwsex2AzqhV5ek1ouxzVyqdxxDDAxFLSxYZn48hEkbkFtljNNUe0IvVjcDPPuVKvBn9uy57eKAIUtcHru/nr7LEhS82edJ7yNz2krP/+7kfi1q/RFBIA4Xl2KGI5aH1h2DZSTawFDYRrKwYjC/KSqubc2IRJug2iq/+TmJBweGE8SgPBdBXZ1zeB9ZSdWB0s4N5g==; s=purelymail2; d=lkcamp.dev; v=1; bh=ekDVyd3HSW+N9GGe5wx6qgFGUh9DrSzRbbdlNF11H4U=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=D611fMmwfmIh/7exGGLPv9bEV0vft4x2GewhYmdBmzzTTvpeH0HYpK9wQ9GbFYu2/KkFloJFOuNEP0ZlQZVByfnQ+8Uo/BOioJekOAxINrL2YEFwR0ELXHdV/lMc0/DH7NSps2VbHM5mkB0uD3ldEeCqi/p8lSuQU3S/oC9023QhKpN20/zoOLZ5CMnJu2qGxzg6Dd69oPqDUiOM1AdyeQXFmaZJCsRGY71Nl9u85rxOIE13asVzWTo4OPghnWu7Z7jU1STc5Lxtv4nkXJiLOcEZiE8i6MAkIc+GsBUQ6LCx5ns5SV/TalhM3Ev19geALSoEAIxQDKPNhXETky2dAw==; s=purelymail2; d=purelymail.com; v=1; bh=ekDVyd3HSW+N9GGe5wx6qgFGUh9DrSzRbbdlNF11H4U=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1324637488;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 04 Oct 2024 20:00:02 +0000 (UTC)
Message-ID: <6a5c9c54-54d9-45d6-b739-269985956513@lkcamp.dev>
Date: Fri, 4 Oct 2024 16:59:58 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] lib/crc16_kunit.c: add KUnit tests for crc16
To: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>,
 linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Enzo Bertoloti <ebertoloti@lkcamp.dev>,
 Fabricio Gasperin <fgasperin@lkcamp.dev>,
 David Laight <David.Laight@aculab.com>
References: <20241003-crc16-kunit-v2-1-5fe74b113e1e@lkcamp.dev>
 <202410050215.eU9509xy-lkp@intel.com>
Content-Language: en-US
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
In-Reply-To: <202410050215.eU9509xy-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/4/24 15:40, kernel test robot wrote:
> Hi Vinicius,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 9852d85ec9d492ebef56dc5f229416c925758edc]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Vinicius-Peixoto/lib-crc16_kunit-c-add-KUnit-tests-for-crc16/20241004-050248
> base:   9852d85ec9d492ebef56dc5f229416c925758edc
> patch link:    https://lore.kernel.org/r/20241003-crc16-kunit-v2-1-5fe74b113e1e%40lkcamp.dev
> patch subject: [PATCH v2] lib/crc16_kunit.c: add KUnit tests for crc16
> config: parisc-randconfig-r071-20241005 (https://download.01.org/0day-ci/archive/20241005/202410050215.eU9509xy-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241005/202410050215.eU9509xy-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410050215.eU9509xy-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> lib/crc16_kunit.c:29: warning: Excess struct member 'crc16' description in 'crc16_test'
>     lib/crc16_kunit.c:96: warning: Function parameter or struct member 'test' not described in 'crc16_test_empty'
>     lib/crc16_kunit.c:111: warning: Function parameter or struct member 'test' not described in 'crc16_test_correctness'
>     lib/crc16_kunit.c:132: warning: Function parameter or struct member 'test' not described in 'crc16_test_combine'
> 

Ah, oops, I forgot to update the function documentation for v2. I will 
fix these warnings in v3.

> Kconfig warnings: (for reference only)
>     WARNING: unmet direct dependencies detected for GET_FREE_REGION
>     Depends on [n]: SPARSEMEM [=n]
>     Selected by [m]:
>     - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]
> 
> 
> vim +29 lib/crc16_kunit.c
> 
>      17	
>      18	/**
>      19	 * struct crc16_test - CRC16 test data
>      20	 * @crc: initial input value to CRC16
>      21	 * @start: Start index within the data buffer
>      22	 * @length: Length of the data
>      23	 * @crc16: Expected CRC16 value for the test
>      24	 */
>      25	static struct crc16_test {
>      26		u16 crc;
>      27		u16 start;
>      28		u16 length;
>    > 29	} tests[CRC16_KUNIT_TEST_SIZE];
>      30	
> 


