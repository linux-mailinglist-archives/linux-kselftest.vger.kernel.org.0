Return-Path: <linux-kselftest+bounces-46096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5DCC73BBD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 12:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD5B24F0020
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 11:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01BF330D51;
	Thu, 20 Nov 2025 11:25:28 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCB1F4168;
	Thu, 20 Nov 2025 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763637928; cv=none; b=YPSy/3iTXBRAMBGOYP/gaP3CgtdGkoBD41otAC3vw5I2+wrk+MCgFZ90gHUJoxz90vMkMMa6I0eTYawy269Rq+aj1OHKO0avOvRF9qElYlMhGzTDqV0wjGVHMqGgOcntzfdC28DArDQlb7c/bpEWy9XsWiqTZdsa5EVh9gCZMtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763637928; c=relaxed/simple;
	bh=OVQAoxY+mxuamsQiRlVi9NCno00ISqASJf4imy/ElCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IppVYculrr0vj/zOJydjxkuonCmB+5JoWyClR5USUX3gJajjzvBiFaTGU3AQFahAKAUPJHBBsL4G6F/n/uojA4RRq/vkbCrNFczVyYHIzW9zmamIcHCK8+Jcq8qIYY7ga24VSpqW20GpVa5UItRHWIpEP3MS1f21ODXWnuYWeKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from Mobilestation.localdomain (unknown [183.6.59.216])
	by APP-05 (Coremail) with SMTP id zQCowADXzV5N+h5pzdhdAQ--.1076S2;
	Thu, 20 Nov 2025 19:24:10 +0800 (CST)
From: Yao Zihong <zihong.plct@isrc.iscas.ac.cn>
To: ajones@ventanamicro.com
Cc: alex@ghiti.fr,
	alexghiti@rivosinc.com,
	aou@eecs.berkeley.edu,
	cleger@rivosinc.com,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	samuel.holland@sifive.com,
	shuah@kernel.org,
	zhangyin2018@iscas.ac.cn,
	zihong.plct@isrc.iscas.ac.cn,
	zihongyao@outlook.com
Subject: Re: [PATCH v5 2/2] selftests/riscv: Add Zicbop prefetch test
Date: Thu, 20 Nov 2025 19:23:50 +0800
Message-ID: <20251120112351.34433-1-zihong.plct@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251118-cbe35d090a464d246ed0b8eb@orel>
References: <20251118-cbe35d090a464d246ed0b8eb@orel>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXzV5N+h5pzdhdAQ--.1076S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYB7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aV
	CY1x0267AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE
	5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI
	0_GFv_Wryl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUosqXDUUUU
X-CM-SenderInfo: p2lk00vjoszunw6l223fol2u1dvotugofq/

Hi Andrew,

On Tue, 18 Nov 2025 10:45:43 -0600, Andrew Jones wrote:
> I would have written it like below to avoid four redundant lines
> 
>  case 'm': case 'z':
>    tests[opt == 'm' ? TEST_NO_ZICBOM : TEST_NO_ZICBOZ].enabled = true;
>    tests[TEST_NO_CBO_INVAL].enabled = true;
>    rc = sigaction(SIGILL, &act, NULL);
>    assert(rc == 0);
>    break;

I'll apply this style pattern in future patches, or in a v6 if we end up
needing one.

Thanks,
Zihong


