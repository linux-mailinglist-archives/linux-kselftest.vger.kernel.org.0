Return-Path: <linux-kselftest+bounces-20553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA239AEB2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B571C24026
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 15:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1651F5835;
	Thu, 24 Oct 2024 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dV1S5ICZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B591E0B6F;
	Thu, 24 Oct 2024 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729785389; cv=none; b=i/EhmooQJZHH4zzAGTtTp6iKX5vKzQugoQY5kMt0xO8lfAIsf4GQZA8QtlF+vIXJCINy0JBSvewClHKNjRkc2zucqocAyGJuArpsNEKvF2jeGYuIfk0eGUOWZItqks1Y9m7K5ZkVS0LmI6oWr70QQcaGYVgdv+3opOUPfl5vSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729785389; c=relaxed/simple;
	bh=IK4bOpKqQ8ZfRYl0RKc3CNMgpunjWfUIWn5lauJpMuI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=bgF+fzfnjYurc8XSI3xLjFWHF425pmGCybla32GKHBXJF3reBB2eUFCli7GzTHbwxpTiahRFHCnuGq2rZmaxlf8YqutVFORSIGhKPA1T+MbZuiAM51+hiuCfZ7gughogYisYi3LazZGn+ith5olQngc2KQ61y53qLjwBgOijqjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dV1S5ICZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dEyOjfWbUxIAyxFc/S0iV8ZJySQkSomEtN2A/QMyFoo=; b=dV1S5ICZvgKROwZdemu1KjNcnX
	H3PJ1kv870MmHX+cSLKhiO93gvmgpf4iUgPsDWjuXUGE4eLZ+7r9bTGIFOm2yLb5LaKMQGqLh94D0
	8dhi6cIqeIo+wH6DLEdXQWs/W4/6mn5UAssAb4e+xJOAdyFIB2BqB21YhOcVMaM8UpsU+1Hktjq7Y
	rs0gdSvdtv+kmvv7Nxg2Pe23YWhAuFy+WkEleVxn7m/9ogbMWEbailZXgQ3yK4MUIP5bR6V/WPdBG
	6lz9VwVetW/w/vnbm5htiSBLov2HkYsYj/WjIFdhCNc16J7vGKufUwWD+gpgdM938TFmM0NsbzzW/
	bGhLnwTw==;
Received: from [31.94.24.214] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t40C6-00000008iBu-12hz;
	Thu, 24 Oct 2024 15:56:14 +0000
Date: Thu, 24 Oct 2024 17:56:09 +0200
From: David Woodhouse <dwmw2@infradead.org>
To: Oliver Upton <oliver.upton@linux.dev>
CC: Miguel Luis <miguel.luis@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Shuah Khan <shuah@kernel.org>,
 David Woodhouse <dwmw@amazon.co.uk>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 Francesco Lavra <francescolavra.fl@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6_6/6=5D_arm64=3A_Use_SYSTEM=5FOF?=
 =?US-ASCII?Q?F2_PSCI_call_to_power_off_for_hibernate?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZxprcWDe2AXuLhD_@linux.dev>
References: <20241019172459.2241939-1-dwmw2@infradead.org> <20241019172459.2241939-7-dwmw2@infradead.org> <23C91005-7304-4312-A5E0-F5E6C05B3209@oracle.com> <ECD0CA58-2C3B-48F3-AF12-95E37CB0FC48@infradead.org> <ZxprcWDe2AXuLhD_@linux.dev>
Message-ID: <691447A1-8F3F-4890-B00F-8068A14CA126@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 24 October 2024 17:44:49 CEST, Oliver Upton <oliver=2Eupton@linux=2Edev>=
 wrote:
>Hi,
>
>On Thu, Oct 24, 2024 at 03:48:26PM +0200, David Woodhouse wrote:
>> On 24 October 2024 14:54:41 CEST, Miguel Luis <miguel=2Eluis@oracle=2Ec=
om> wrote:
>> >Perhaps spec=2E F=2Eb=2E could be accommodated by first invoking SYSTE=
M_OFF2 with
>> >PSCI_1_3_OFF_TYPE_HIBERNATE_OFF and checking its return value in case =
of a
>> >fallback to an invocation with 0x0 ?
>
>This already complies with F=2Eb=2E
>
>The PSCI implementation is required to accept either 0 or 1 for
>HIBERNATE_OFF=2E Using 0 seems like a good choice for compatibility since=
 =2E=2E=2E
>
>> I wasn't aware there was any point=2E Are there any hypervisors which a=
ctually implemented it that way? Amazon Linux and Ubuntu guests already jus=
t use zero=2E
>>=20
>> We could add it later if such a hypervisor (now in violation of F=2Eb) =
turns up, I suppose?
>
>IIUC, you're really wanting to 0x0 because there are hypervisors out
>there that violate the final spec and *only* accept this value=2E
>
>That's perfectly fine, but it'd help avoid confusion if the supporting
>comment was a bit more direct:
>
>	/*
>	 * If no hibernate type is specified SYSTEM_OFF2 defaults to
>	 * selecting HIBERNATE_OFF=2E
>	 *
>	 * There are hypervisors in the wild that violate the spec and
>	 * reject calls that explicitly provide a hibernate type=2E For
>	 * compatibility with these nonstandard implementations, pass 0
>	 * as the type=2E
>	 */
>	 if (system_entering_hibernation())
>		invoke_psci_fn(PSCI_FN_NATIVE(1_3, SYSTEM_OFF2), 0 , 0, 0);

By the time this makes it into released versions of the guest Linux kernel=
, that comment won't be true any more=2E


