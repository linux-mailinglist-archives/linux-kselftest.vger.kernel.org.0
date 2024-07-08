Return-Path: <linux-kselftest+bounces-13338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7854C92AB5E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 23:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076E21F22A77
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 21:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE0A14EC53;
	Mon,  8 Jul 2024 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLWHmPh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123D149C6A
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jul 2024 21:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720474811; cv=none; b=EVe0Q71sVzKFYRC2Ob4YAskB2VeVshz5bg5s93hJkYVKf9imtIShhoAj6RkA08YvIhCtlBd9Ajedb4kCJXaLeXwaKw9FNDS0j0iR3ZBLCo9MenwgV4pADRL9A7X4TcoeeMvCLG4+GvXg0ezUd500dQBe6CFbnZocnbgd8afJnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720474811; c=relaxed/simple;
	bh=ksWUl+7oU5im94h1dU1dhvwd56cmIXpc/qZXAFf5Rs4=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdXuHzFU4Ijnq2F+B9l3ElGP3CWEz4AiSMNGZr/FZ8NLJuJZSTJAF7kfcmrXoukByiza0+X/qyrLAWo6pEo5d8n3ZKB19hS0UOYDfrSV9deS7PAOOyEjJ9UTem/TgL+hVcExOgRj1lDLVMTvzfKVUvyKh46A4R9HE0hjVJ6V8x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLWHmPh9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720474808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrmMfuh6zl+J0VMmb+jXkVGZeQnzPMh5oQVddVrOdbk=;
	b=SLWHmPh93gTaXfRS39V4mac1zkGdMRp1q1MzkgFbhXpsU7JkY6Gc2/8ftflDQIfnDv+TKM
	gUXRHmZm+ssJIZLNgg2L36ivr5kO6l5Xx5fljVr5CdHxe/hBGCZadMGso5ZwgEJWfAkjMG
	XVeACqD4KSYKerGoC6nQUJ7E272wkE8=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-VIhUHfUqOrioxtuT9zZfhQ-1; Mon, 08 Jul 2024 17:40:07 -0400
X-MC-Unique: VIhUHfUqOrioxtuT9zZfhQ-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e039b77a040so7297258276.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jul 2024 14:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720474806; x=1721079606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xrmMfuh6zl+J0VMmb+jXkVGZeQnzPMh5oQVddVrOdbk=;
        b=S+7vg28+UJZfn3ZN1FZkkoqn08kZ7zIRmRyy3qiMak69UjAtVJx6Ae1xOxDxpyIEHP
         uwfqMLFFKN48indEbp0pnZgYN7sqG32GipfZAM9SunGrBm6H7y5IeP7qE+HF+O1PK8ot
         FDJy35+oFYkHRU2y2zEEmKq8PuCJTppLVnUqHKDA5gpBqcxqa/EJsHU1GKGCs0ySU5TO
         9t2BffONnaEgeF+zzOFI5RUeoigvfbZLdMlwVoI/xKwvOugeirm7NDntRgY1TDTonLzu
         UJ45HRllK8VpvygKXt7POAyZgzZA3EZ/bR+dDNqR3P+NPFQiKYJXDs8A0dI1fykeek+/
         MeHA==
X-Forwarded-Encrypted: i=1; AJvYcCW1+BEk2Gizxvt3gq3y4va18ISEsj+UM3SKb9ui3po7sihreMxPWxz4iXUEsqPmTabI+0WajM1WyF72Dz+0S8IzqvsM0VDUyFJsA80SQqKs
X-Gm-Message-State: AOJu0Yx4a9jnzxMPJ30DzNmDWdRIZQPx4h6HRy3haf/xgZ9v3kwoc7Rw
	z5fZfx8f1YED2j5iCVenis/OcA8izUVvNkJMpqNNLHNFWlFASD77nJ9Z/tTYopFRNf7Lo3AFQSg
	h0+ehJgcaK7wuEGJRTfTG1FHGvpMqTEtQNndZyrBQy0j3FDPvsV1MlLnpz4WCmw7CPLO/+tXfcs
	T+KpveueMOwZGgqV1LX7V+37V6Ar1TUFFQqYM/EiRKAaARA6PO
X-Received: by 2002:a25:dc91:0:b0:e03:4e3b:2a49 with SMTP id 3f1490d57ef6-e041b15b11amr1075169276.60.1720474806279;
        Mon, 08 Jul 2024 14:40:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhcBFn0ofqIUHCwGg3OYl0O2Ng3lLsFfo+cuSb6XyWrWH/AvKTaMcedW1YcTsjxqISDHxVyzi9sPAVrwvwT+A=
X-Received: by 2002:a25:dc91:0:b0:e03:4e3b:2a49 with SMTP id
 3f1490d57ef6-e041b15b11amr1075148276.60.1720474805979; Mon, 08 Jul 2024
 14:40:05 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jul 2024 14:40:05 -0700
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240708134451.3489802-1-amorenoz@redhat.com> <0fd40aed-04d1-43a3-ab3d-c7459a63f753@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0fd40aed-04d1-43a3-ab3d-c7459a63f753@ovn.org>
Date: Mon, 8 Jul 2024 14:40:05 -0700
Message-ID: <CAG=2xmO3Je7W0pstvN_ALFcNFRqTLCaRhaCV=O+2VEu5_e+g-A@mail.gmail.com>
Subject: Re: [ovs-dev] [PATCH v1] selftests: openvswitch: retry instead of sleep
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Aaron Conole <aconole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 09:31:58PM GMT, Ilya Maximets wrote:
> On 7/8/24 15:44, Adrian Moreno wrote:
> > There are a couple of places where the test script "sleep"s to wait for
> > some external condition to be met.
> >
> > This is error prone, specially in slow systems (identified in CI by
> > "KSFT_MACHINE_SLOW=3Dyes").
> >
> > To fix this, add a "ovs_wait" function that tries to execute a command
> > a few times until it succeeds. The timeout used is set to 5s for
> > "normal" systems and doubled if a slow CI machine is detected.
> >
> > This should make the following work:
> >
> > $ vng --build  \
> >     --config tools/testing/selftests/net/config \
> >     --config kernel/configs/debug.config
> >
> > $ vng --run . --user root -- "make -C tools/testing/selftests/ \
> >     KSFT_MACHINE_SLOW=3Dyes TARGETS=3Dnet/openvswitch run_tests"
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  .../selftests/net/openvswitch/openvswitch.sh  | 49 ++++++++++++++++---
> >  .../selftests/net/openvswitch/ovs-dpctl.py    |  1 +
> >  2 files changed, 42 insertions(+), 8 deletions(-)
> >
>
> Hi, Adrian.  See a small pile of nitpicks below.
>
> None of them are blocking from my perspective, except for a typo.
> Just listed them since there is a typo anyway.
>
> > diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/t=
ools/testing/selftests/net/openvswitch/openvswitch.sh
> > index bc71dbc18b21..83407b42073a 100755
> > --- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > +++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
> > @@ -11,6 +11,7 @@ ksft_skip=3D4
> >  PAUSE_ON_FAIL=3Dno
> >  VERBOSE=3D0
> >  TRACING=3D0
> > +WAIT_TIMEOUT=3D5
> >
> >  tests=3D"
> >  	arp_ping				eth-arp: Basic arp ping between two NS
> > @@ -29,6 +30,32 @@ info() {
> >  	[ $VERBOSE =3D 0 ] || echo $*
> >  }
> >
> > +ovs_wait() {
> > +	info "waiting $WAIT_TIMEOUT s for: $@"
> > +
> > +	"$@"
> > +	if [[ $? -eq 0 ]]; then
>
> Maybe just 'if "$@"; then' ?
>

In my head this is a bit less clean but I don't mind.

> > +		info "wait succeeded inmediately"
>
> * immediately

Thanks. Will fix the typo.

>
> > +		return 0
> > +	fi
> > +
> > +	# A quick re-check helps speed up small races in fast systems.
> > +	# However, fractional sleeps might not necessarily work.
> > +	local start=3D0
> > +	sleep 0.1 || { sleep 1; start=3D1; }
> > +
> > +	for (( i=3Dstart; i<WAIT_TIMEOUT; i++ )); do
>
> for i in $(seq ${start} ${WAIT_TIMEOUT}); do
>
> Will need to initialize start to 1 and 2.
>
> It works, but seems like an unnecessary use of non-POSIX constructs.

The reason why I chose this form is that I find it more robust on a
script that changes IFS. If this function is called within a block that
has changed IFS, "i" will take the entire sequence as the value for the
first iteration.

>
> > +		"$@"
> > +		if [[ $? -eq 0 ]]; then
>
> if "$@"; then
>
> > +			info "wait succeeded after $i seconds"
> > +			return 0
> > +		fi
> > +		sleep 1
> > +	done
> > +	info "wait failed after $i seconds"
> > +	return 1
> > +}
> > +
> >  ovs_base=3D`pwd`
> >  sbxs=3D
> >  sbx_add () {
> > @@ -278,20 +305,21 @@ test_psample() {
> >
> >  	# Record psample data.
> >  	ovs_spawn_daemon "test_psample" python3 $ovs_base/ovs-dpctl.py psampl=
e-events
> > +	ovs_wait grep -q "listening for psample events" ${ovs_dir}/stdout
> >
> >  	# Send a single ping.
> > -	sleep 1
> >  	ovs_sbx "test_psample" ip netns exec client ping -I c1 172.31.110.20 =
-c 1 || return 1
> > -	sleep 1
> >
> >  	# We should have received one userspace action upcall and 2 psample p=
ackets.
> > -	grep -E "userspace action command" $ovs_dir/s0.out >/dev/null 2>&1 ||=
 return 1
> > +	ovs_wait grep -q "userspace action command" $ovs_dir/s0.out
> > +	[[ $? -eq 0 ]] || return 1
>
> Why checking separately and not one the same line with || return 1 ?

IMHO, passing complex commands to a function in bash can easily get very
problematic. That's why I try to remove all pipes, redirections or
logical operators like && and ||. At least for me it removes one extra
cycle that my brain has to spend looking at quotes and figuring out if
the operand will be interpreted inside the function or outside.

> Also double brackets seem unnecessary.

That's true.

>
> >
> >  	# client -> server samples should only contain the first 14 bytes of =
the packet.
> > -	grep -E "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f]{28}$" \
> > -			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
> > -	grep -E "rate:4294967295,group:2,cookie:eeff0c" \
> > -			 $ovs_dir/stdout >/dev/null 2>&1 || return 1
> > +	ovs_wait grep -qE "rate:4294967295,group:1,cookie:c0ffee data:[0-9a-f=
]{28}$" $ovs_dir/stdout
> > +	[[ $? -eq 0 ]] || return 1
> > +
> > +	ovs_wait grep -q "rate:4294967295,group:2,cookie:eeff0c" $ovs_dir/std=
out
> > +	[[ $? -eq 0 ]] || return 1
>
> Same for above two.
>
> >
> >  	return 0
> >  }
> > @@ -711,7 +739,8 @@ test_upcall_interfaces() {
> >  	ovs_add_netns_and_veths "test_upcall_interfaces" ui0 upc left0 l0 \
> >  	    172.31.110.1/24 -u || return 1
> >
> > -	sleep 1
> > +	ovs_wait grep -q "listening on upcall packet handler" ${ovs_dir}/left=
0.out
> > +
> >  	info "sending arping"
> >  	ip netns exec upc arping -I l0 172.31.110.20 -c 1 \
> >  	    >$ovs_dir/arping.stdout 2>$ovs_dir/arping.stderr
> > @@ -811,6 +840,10 @@ shift $(($OPTIND-1))
> >  IFS=3D"=09
> >  "
> >
> > +if test "X$KSFT_MACHINE_SLOW" =3D=3D "Xyes"; then
> > +	WAIT_TIMEOUT=3D10
> > +fi
>
> Should this be done closer to the first initialization of WAIT_TIMEOUT ?
>

My rationale was splitting "variable declaration" and "code". Sure
we're not adding an explicit cli argument for this (as with TRACING or
VERBOSE) but we kind-of are using KSFT_MACHINE_SLOW as an input so for
me grouping input processing all together made some sense. Having said
that, I don't have a very strong opinion. I guess we can move it up as
well.

> > +
> >  for arg do
> >  	# Check first that all requested tests are available before running a=
ny
> >  	command -v > /dev/null "test_${arg}" || { echo "=3D=3D=3D Test ${arg}=
 not found"; usage; }
> > diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/too=
ls/testing/selftests/net/openvswitch/ovs-dpctl.py
> > index 1e15b0818074..8a0396bfaf99 100644
> > --- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > +++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> > @@ -2520,6 +2520,7 @@ class PsampleEvent(EventSocket):
> >      marshal_class =3D psample_msg
> >
> >      def read_samples(self):
> > +        print("listening for psample events", flush=3DTrue)
> >          while True:
> >              try:
> >                  for msg in self.get():
>

Thanks.
Adri=C3=A1n


