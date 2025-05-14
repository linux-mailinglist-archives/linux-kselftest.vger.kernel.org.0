Return-Path: <linux-kselftest+bounces-32955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF65AB7306
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 19:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C383B5883
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 17:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9882E27FD7F;
	Wed, 14 May 2025 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="o/v9xMLo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [131.188.11.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21E18DB37;
	Wed, 14 May 2025 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.188.11.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244439; cv=none; b=iJldxcg50a4cTCJ+G+cT3x4q50DYSeGigSKMeQj+tYs6NXll5uSlWfFu6baVnG8tXZGOsDczGEOsLg/lF+LAcf9AQ0jwb7niARVaeOPj4rD4UowI1y8c4wY3Kj4AMe6asyedZqObcfldo91oeZ03YBzuIUGYC39QvRpMBbHt470=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244439; c=relaxed/simple;
	bh=hS9rND3wioY6eDbAy+sk/6+G1OWEbRvsk+fcHfxsxIo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qHnX4TE84r/mP9xYYn3b4tKCs12BV1KJ6E0QH2ubTW0sERPQTELzrQj4VNZ7qPJ+8wrJU018UCB7hvyIRLknkJWnV3LBTtWLq5s4qv23gnR+wBX8WgVTj/eJBLhGrA/7UuO5eiGMIvy2hfaOQS7h+SVojQYvJlUYEtaWpnuzwXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de; spf=pass smtp.mailfrom=fau.de; dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b=o/v9xMLo; arc=none smtp.client-ip=131.188.11.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1747243854; bh=3e0BofRXBhWdxRuieDvo8KpaPQ4BE/s7KyUPUjxLUy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=o/v9xMLoLEt+/EY/F/2hiul7G9q9dVfTBoHsfj6PXfkZFOSFMdQQBavF/drmR4rpL
	 DgVdmTvlc6POarsmEEmRDC8f9XB32EUFRahN2mBnDpa7EIkU+No5WrItvRHVwRezCY
	 LhPzBIW1wHkJbx/Km70XS3uu5TohveXjPX5fj4gvBQwxLgO8a1kQjnOafENXDmRuH4
	 q6MPQdadYlu5KmCBX7pTTw8KmkFCqSlRa1WuK/xH9t3y9PqHf/QQiXwkP/9m+FOyWQ
	 l+IW74ia2BZt0gCbP7yqABiYtBCbon1DFCjotNmYpkRQSKuJCi97P1w28X0FIOQtg2
	 BRdIPDkilXjDw==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4ZyL3L0f4Kz8smT;
	Wed, 14 May 2025 19:30:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:9e8:3603:f000:9789:61c6:ec86:c048
Received: from localhost (unknown [IPv6:2001:9e8:3603:f000:9789:61c6:ec86:c048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1/rt5rGkAuQIth1KALZmUps9hhST9T84As=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4ZyL3G4bZ7z8t8S;
	Wed, 14 May 2025 19:30:50 +0200 (CEST)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,
  John Fastabend <john.fastabend@gmail.com>,  KP Singh
 <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Puranjay Mohan
 <puranjay@kernel.org>,  Xu Kuohai <xukuohai@huaweicloud.com>,  Catalin
 Marinas <catalin.marinas@arm.com>,  Will Deacon <will@kernel.org>,  Hari
 Bathini <hbathini@linux.ibm.com>,  Christophe Leroy
 <christophe.leroy@csgroup.eu>,  Naveen N Rao <naveen@kernel.org>,
  Madhavan Srinivasan <maddy@linux.ibm.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  Mykola
 Lysenko <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>,  Henriette
 Herzog <henriette.herzog@rub.de>,  Saket Kumar Bhaskar
 <skb99@linux.ibm.com>,  Cupertino Miranda <cupertino.miranda@oracle.com>,
  Jiayuan Chen <mrpre@163.com>,  Matan Shachnai <m.shachnai@gmail.com>,
  Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,  Shung-Hsi Yu
 <shung-hsi.yu@suse.com>,  Daniel Xu <dxu@dxuuu.xyz>,  bpf@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  linuxppc-dev@lists.ozlabs.org,  linux-kselftest@vger.kernel.org,
  Maximilian Ott <ott@cs.fau.de>,  Milan Stephan <milan.stephan@fau.de>
Subject: Re: [PATCH bpf-next v3 11/11] bpf: Fall back to nospec for
 sanitization-failures
In-Reply-To: <CAP01T76jeSg3W-OyfBfSbAjpEhBr_h8rbS-Hubk6gDdrkeEj_Q@mail.gmail.com>
	(Kumar Kartikeya Dwivedi's message of "Wed, 14 May 2025 02:47:44 -0400")
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
	<20250501073603.1402960-12-luis.gerhorst@fau.de>
	<CAP01T76jeSg3W-OyfBfSbAjpEhBr_h8rbS-Hubk6gDdrkeEj_Q@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 30.1
Date: Wed, 14 May 2025 19:30:50 +0200
Message-ID: <87ecwr14mt.fsf@fau.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

(including relevant part from other message)

> On Thu, 1 May 2025 at 04:00, Luis Gerhorst <luis.gerhorst@fau.de> wrote:
> 
>> +static bool error_recoverable_with_nospec(int err)
>> +{
>> +       /* Should only return true for non-fatal errors that are allowed to
>> +        * occur during speculative verification. For these we can insert a
>> +        * nospec and the program might still be accepted. Do not include
>> +        * something like ENOMEM because it is likely to re-occur for the next
>> +        * architectural path once it has been recovered-from in all speculative
>> +        * paths.
>> +        */
>> +       return err == -EPERM || err == -EACCES || err == -EINVAL;
>> +}
> 
> Why can't we unconditionally do this? So the path with speculation
> that encounters an error (even if EFAULT) is not explored for the
> remaining pushed speculative states. If the error remains regardless
> of speculation normal symbolic execution will encounter it. The
> instructions only explored as part of speculative execution are not
> marked as seen (see: sanitize_mark_insn_seen), so they'll be dead code
> eliminated and the code doesn't reach the JIT, so no "unsafe gadget"
> remains in the program where execution can be steered.
> 
> So the simplest thing (without having to reason about these three
> error codes, I'm sure things will get out of sync or we'll miss
> potential candidates) is probably to just unconditionally mark
> cur_aux(env)->nospec.

[...]

> Hm, now looking at this and thinking more about this, I think
> recoverable error logic is probably ok as is.
> Scratch my earlier suggestion about unconditional handling. I guess
> what would be better would be
> handling everything except fatal ones. In case of fatal ones we should
> really quit verification and return.
> We may make partial changes to verifier state / env and try to bail
> out using -ENOMEM and -EFAULT.
> So unconditional continuation would be problematic as we'd act in a
> partial state never meant to be seen.
>
> The logic otherwise looks ok, so:
>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thank you very much for having a look, so then I will leave it as is if
I understand you correctly.

Please let me know if "what would be better would be handling everything
except fatal ones" was meant literally. Such a deny-list approach would
likely be:

  return err != -ENOMEM && err != -EFAULT;

I initially decided to limit it to -EPERM, -EACCES, and -EINVAL as I was
relatively confident all their cases were safe to "catch" and because it
already had the desired effect for most real-world programs. However, if
you find the deny-list approach easier to reason about, I can also do
that. In that case, I will review the remaining errors (besides -EPERM,
-EACCES, and -EINVAL) and make sure they can be caught.

Also, thanks for the pointer regarding sanitize_check_bounds() (sorry
for the delay; the message is still on my to-do list). I will address it
in v4 if it is safe or send a separate fix if it is indeed a bug.

