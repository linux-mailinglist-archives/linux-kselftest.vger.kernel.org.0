Return-Path: <linux-kselftest+bounces-20381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 523849AA038
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 12:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEAA1F2125B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504419A2BD;
	Tue, 22 Oct 2024 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="COiiTWI4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFED915574F
	for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 10:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729593665; cv=none; b=p5pX4bVhNliCIQfl1X4TjJ3T8nIOGx50BXaPTPJN5M1W9kcbSQS1ODU6hJcn+yPv/mogmEh4OzjfvzUJZkirrbY+iOmilANRpxUFt5kx5+Z5MPw5dyD2aoOTLRIo7zeb0Xg82gTf+3PuxGrQSMlpsR0NNVWQDPn0Pmb8ix1yo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729593665; c=relaxed/simple;
	bh=u1BQnVyU7tl8/aAmmUw7Dt6ALGbF5+Jfagiu4TYqo4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYFAaPgBwc6t3T6gj+GHzFDA0qzeQ/yf5HIRluSRBN8+F6dB0tgbbcK4KIln2sevan4ECoUXQ7NO0o8hr1+zccx+4Hhp9WLkFFe1TBDOM4FMBbvKw2LvycBwgDzVyKrepMCGmLfs8WBwjNFZEdX70aq7Cd3ucVFQersD+BaGi+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=COiiTWI4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43161c0068bso40457505e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Oct 2024 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729593662; x=1730198462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dvvTDtyitjkdLC8BHyI1Fz6cvDsKRJmq65w2o90b5+c=;
        b=COiiTWI4C4Xi7H2rR81mpiTBtoAKARwDI2gWJYuC1UbF68CKbPu7fEB3nCYGqST+Us
         Bc61zNE3fyqJs3GHYPyeyTQWMDLc01X6NMyzDRL3kZZUzSC825CLGlWPMy7M0J47nFP2
         Vy7J4IflcSUyf+cSuYUg92iFx76t/n/DXnwquD4xCfy8RBul06rpZRe+rmxqb0SXQ6w+
         lzNXS9AmAjdoW7gWMzq4DsmHkE80hsPatbCgHgpVryjDTETLSSUEF8V/2kY+XRdu8YhT
         ZYpf2NSgtBZe7dW+R2yvt3N18YlIPeF+kpylaIFqAt06eCcy+XAJffDrsYl/8IXr1RYR
         Fa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729593662; x=1730198462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvvTDtyitjkdLC8BHyI1Fz6cvDsKRJmq65w2o90b5+c=;
        b=GiqoSD8iQhEj0za5Md6tY2tK9TSkIY953+9C7B59qHoDl5vBi+6Xx3cOi0IOEHORb9
         EF9yEDxMbyb7G4UutTMLxnTm0BTQxHlI6sT741ey9TziAUvc/YOzPVCkPzqsT/HUBkEC
         XR2IXFv6NmG6i1ZriII1svVPhtZWu6pBmXGibeKow0ayvaggPUspKfJk2yy39kE8PAQa
         7H5m6RTmPTGsBFidO96T7TCHvg3bKczMC90Lj/L0+3Im6TeVeb2Rmauiwk1gTIQMPDm6
         Sx8NbiLPmOf0sqNDCSR0PuC/TvdT+LbFxes579jdiJbGXwaorDdpDyt5G5FWe9obsKyt
         zSWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTDdisvkN9Hafw6+3pdWduXqX2MtV9Dhr5myC1t5o4ajNz8Ut9WgCAIMU/d62RDq84GqEHQOhD2eXjTLFy7CM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDE55UY5LqB2RXZmYrzLM9X4tbamPzXNTD6p5rgT5IBVQr187i
	ybRlKQ251c02ekeK2x0sBb30YGRJGcCMqs4i51RVmot5iPYWrYoWWrHu1oqobE2O8qwtAKQnNrf
	KPo/xDK3YhWh8o0XmELBUooQFJ+tIC9aXwlvr
X-Google-Smtp-Source: AGHT+IGW+cF1118fQxIuyciV14cxbpvtkoTd3XhHbn6uRIgrzaq5G0IwMCtkpPrPA1kec46ppM08GUTF+UFfplb3rt8=
X-Received: by 2002:a05:600c:4751:b0:430:563a:b20a with SMTP id
 5b1f17b1804b1-431616494a9mr120413985e9.11.1729593661861; Tue, 22 Oct 2024
 03:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
 <ZxEx5aXPX2mHngoB@e133380.arm.com> <627c1297-8151-43d1-b46b-a962301b18fa@arm.com>
 <ZxZXnM9vUj+tex/z@e133380.arm.com> <87plns8owh.fsf@arm.com>
In-Reply-To: <87plns8owh.fsf@arm.com>
From: =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date: Tue, 22 Oct 2024 12:40:45 +0200
Message-ID: <CAEAAPHahaDTExqwRPXcP9DTJO=VC6dupqnK=28JiGwmbL3fQmA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Improve arm64 pkeys handling in signal delivery
To: Pierre Langlois <pierre.langlois@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, Anshuman Khandual <Anshuman.Khandual@arm.com>, 
	"aruna.ramakrishna@oracle.com" <aruna.ramakrishna@oracle.com>, "broonie@kernel.org" <broonie@kernel.org>, 
	Catalin Marinas <Catalin.Marinas@arm.com>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "jeffxu@chromium.org" <jeffxu@chromium.org>, 
	Joey Gouly <Joey.Gouly@arm.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"will@kernel.org" <will@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, nd@arm.com, 
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ddf27706250e676f"

--000000000000ddf27706250e676f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:31=E2=80=AFAM Pierre Langlois
<pierre.langlois@arm.com> wrote:
>
> Dave Martin <Dave.Martin@arm.com> writes:
>
> > On Mon, Oct 21, 2024 at 12:06:25PM +0200, Kevin Brodsky wrote:
> >> On 17/10/2024 17:48, Dave Martin wrote:
> >> > On Thu, Oct 17, 2024 at 02:39:04PM +0100, Kevin Brodsky wrote:
> >> >> This series is a follow-up to Joey's Permission Overlay Extension (=
POE)
> >> >> series [1] that recently landed on mainline. The goal is to improve=
 the
> >> >> way we handle the register that governs which pkeys/POIndex are
> >> >> accessible (POR_EL0) during signal delivery. As things stand, we ma=
y
> >> >> unexpectedly fail to write the signal frame on the stack because PO=
R_EL0
> >> >> is not reset before the uaccess operations. See patch 3 for more de=
tails
> >> >> and the main changes this series brings.
> >> >>
> >> >> A similar series landed recently for x86/MPK [2]; the present serie=
s
> >> >> aims at aligning arm64 with x86. Worth noting: once the signal fram=
e is
> >> >> written, POR_EL0 is still set to POR_EL0_INIT, granting access to p=
key 0
> >> >> only. This means that a program that sets up an alternate signal st=
ack
> >> >> with a non-zero pkey will need some assembly trampoline to set POR_=
EL0
> >> >> before invoking the real signal handler, as discussed here [3].
> >> > This feels a bit bogus (though it's anyway orthogonal to this series=
).
> >>
> >> I'm not very fond of this either. However I believe this is the correc=
t
> >> first step: bring arm64 in line with x86. Removing all restrictions
> >> before uaccess and then setting POR_EL0 to POR_EL0_INIT enables
> >> userspace to use any pkey for the alternate signal stack without an AB=
I
> >> change, albeit not in a very comfortable way (if the pkey is not 0).
> >
> > I see: we try not to prevent userspace from using whatever pkey it
> > likes for the alternate signal stack, but we are only permissive for
> > the bare minimum operations that userspace can't possibly control for
> > itself (i.e., writing the signal frame).
> >
> > This whole thing feels a bit of a botch, though.
> >
> > Do we know of anyone actually using a sigaltstack with a pkey other
> > than 0?  Why the urgency?  Code relying on an asm shim on x86 is
> > already nonportable, unless I've misunderstood something, so simply
> > turning on arm64 pkeys support in the kernel and libc shouldn't break
> > anything today?  (At least, nothing that wasn't asking to be broken.)
>
> As far as I know, Chrome plans on using a sigaltstack with a non-zero
> pkey as part of the V8 CFI and W^X work [0][1][2]. IIUC that was is part
> of the motivation for the x86 change. I don't know if it's urgent
> though.
>
> I added Stephen on CC who might be able to comment on the current state
> of things in Chrome. I don't think the code that uses a pkey on a
> sigaltstack is upstream yet.

We don't have any code for this in Chrome, since I believe it's not
supported by the kernel yet.

> [0]: https://v8.dev/blog/control-flow-integrity#signal-frame-corruption
> [1]: https://lore.kernel.org/lkml/CAEAAPHa3g0QwU=3DDZ2zVCqTCSh-+n2TtVKrQ0=
7LvpwDjQ-F09gA@mail.gmail.com/
> [2]: https://docs.google.com/document/d/1O2jwK4dxI3nRcOJuPYkonhTkNQfbmwdv=
xQMyXgeaRHo
>
> >
> >>
> >> > Really, we want some way for userspace to tell the kernel what
> >> > permissions to use for the alternate signal stack and signal handler
> >> > using it, and then honour that request consistently (just as we try =
to
> >> > do for the main stack today).
> >> >
> >> > ss_flags is mostly unused... I wonder whether we could add something=
 in
> >> > there?  Or add a sigaltstack2()?
> >>
> >> Yes, this would be sensible as a second step (backwards-compatible
> >> extension). Exactly how that API would look like is not trivial though=
:
> >> is the pkey implicitly derived from the pointer provided to
> >> sigaltstack()? Is there a need to specify another pkey for code, or do
> >> we just assume that the signal handler is only using code with pkey 0?
> >> (Not a concern on x86 as MPK doesn't restrict execution.) Would be ver=
y
> >> interested to hear opinions on this.
>
> I hadn't considered setting a non-zero pkey for code, but it sounds
> appealing.
>
> The general goal, IIUC, is for signal handlers to run in an isolated
> "context" using pkeys, in order to mitigate against an attacker trying
> to corrupt the CPU state on the stack from another thread. Then use this
> as a way to bypass any CFI mitigation, by setting an arbitrary PC and
> registers.

Right. We're mainly looking for a solution to protect the signal frame
against memory corruption.
I'm aware of two proposals on how to achieve this:
1) is using a pkey-protected sigaltstack, which requires a patchset
like [0] to allow xsave to write to the stack
2) is to store part of the sigframe on the shadow stack as Rick
Edgecombe proposed in [1]

[0] https://lore.kernel.org/lkml/20240802061318.2140081-1-aruna.ramakrishna=
@oracle.com/#t
[1] https://lore.kernel.org/lkml/2fb80876e286b4db8f9ef36bcce04bbf02af0de2.c=
amel@intel.com/

> So sigaltstack+pkey helps with isolating the stack. Then it's up to the
> programmer to carefully write the signal handler code so it only uses
> pkey-tagged data that other threads cannot corrupt in order to trick the
> signal handler into writing to its own stack.
>
> In this context, using a non-default pkey for code might be useful, in
> order to differentiate between "valid" signal handlers and other
> functions. It could help fend against an attacker being able to use
> sigaction as a whole-function gadget to install any function as a signal
> hander. Basically mitigating going from a limited CFI bypass to an
> arbitrary CFI bypass.
>
> That being said, regarding the kernel API, it might be possible to do
> the above with this patch. We'd be using the proposed "assembly
> prologues" that sets POR_EL0 as the first thing then continues to the
> real signal handler. But if we can avoid those and directly ask the
> kernel what POR_EL0 should be set to, it'd be simpler (and maybe safer).
>
> >>
> >> Kevin
> >
> > I would vote for specifying the pkey (or, if feasible, PKRU or
> > modifications to it) in some bits of ss_flags, or in an additional
> > flags argument to sigaltstack2().
> >
> > Memory with a non-zero pkey cannot be used 100% portably, period, and
> > having non-RW(X) permissions on pkey 0 at any time is also not
> > portable, period.  So I'm not sure that having libc magically guess
> > what userspace's pkeys policy is supposed to be based on racily digging
> > metadata out of /proc/self/maps or a cache of it etc. would be such a
> > good idea.
> >
> > There are other ways to approach (or not approach) this though --
> > I would be interested to hear what other people think too...
>
> Thinking about this, I'm not sure about tying this API to sigaltstack,
> as this is about configuring the POR_EL0 register, which may control
> more than the stack.
>
> I actually have a concrete example of this in V8. There's a
> SetDefaultPermissionsForSignalHandler [3] function that needs to be
> called first thing on signal handlers to configure access to an
> allocated non-zero key.  This is independent from having a pkey-tagged
> sigaltstack or not, but I suppose later on it will need to be replaced
> with assembly when the stack is no-longer accessible.
>
> [3]: https://source.chromium.org/chromium/chromium/src/+/main:v8/include/=
v8-platform.h;l=3D665;drc=3D0abf23ec2a1bb475b1555790fdc72ef630a43c2a;bpv=3D=
1;bpt=3D1
>
> Doing this via sigaction as Catalin suggested makes sense to me, but I'm
> unsure how we express how POR_EL0 needs to be set solely using SA_*
> flags. Are we able to add a new architecture-specific payload to
> sigaction, or would that resort in a new syscall like sigaction2?
>
> As an alternative, I was wondering if this would warrant a new syscall
> like sigaltstack, but for CPU state.
>
> Thanks,
> Pierre

--000000000000ddf27706250e676f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUrAYJKoZIhvcNAQcCoIIUnTCCFJkCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIGMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNDdaFw0zMjA0MTkwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFI2IFNNSU1FIENBIDIwMjMwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDYydcdmKyg
4IBqVjT4XMf6SR2Ix+1ChW2efX6LpapgGIl63csmTdJQw8EcbwU9C691spkltzTASK2Ayi4aeosB
mk63SPrdVjJNNTkSbTowej3xVVGnYwAjZ6/qcrIgRUNtd/mbtG7j9W80JoP6o2Szu6/mdjb/yxRM
KaCDlloE9vID2jSNB5qOGkKKvN0x6I5e/B1Y6tidYDHemkW4Qv9mfE3xtDAoe5ygUvKA4KHQTOIy
VQEFpd/ZAu1yvrEeA/egkcmdJs6o47sxfo9p/fGNsLm/TOOZg5aj5RHJbZlc0zQ3yZt1wh+NEe3x
ewU5ZoFnETCjjTKz16eJ5RE21EmnCtLb3kU1s+t/L0RUU3XUAzMeBVYBEsEmNnbo1UiiuwUZBWiJ
vMBxd9LeIodDzz3ULIN5Q84oYBOeWGI2ILvplRe9Fx/WBjHhl9rJgAXs2h9dAMVeEYIYkvW+9mpt
BIU9cXUiO0bky1lumSRRg11fOgRzIJQsphStaOq5OPTb3pBiNpwWvYpvv5kCG2X58GfdR8SWA+fm
OLXHcb5lRljrS4rT9MROG/QkZgNtoFLBo/r7qANrtlyAwPx5zPsQSwG9r8SFdgMTHnA2eWCZPOmN
1Tt4xU4v9mQIHNqQBuNJLjlxvalUOdTRgw21OJAFt6Ncx5j/20Qw9FECnP+B3EPVmQIDAQABo4IB
ZTCCAWEwDgYDVR0PAQH/BAQDAgGGMDMGA1UdJQQsMCoGCCsGAQUFBwMCBggrBgEFBQcDBAYJKwYB
BAGCNxUGBgkrBgEEAYI3FQUwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNVHQ4EFgQUM7q+o9Q5TSoZ
18hmkmiB/cHGycYwHwYDVR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwewYIKwYBBQUHAQEE
bzBtMC4GCCsGAQUFBzABhiJodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5jb20vcm9vdHI2MDsGCCsG
AQUFBzAChi9odHRwOi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9yb290LXI2LmNydDA2
BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL3Jvb3QtcjYuY3JsMBEG
A1UdIAQKMAgwBgYEVR0gADANBgkqhkiG9w0BAQwFAAOCAgEAVc4mpSLg9A6QpSq1JNO6tURZ4rBI
MkwhqdLrEsKs8z40RyxMURo+B2ZljZmFLcEVxyNt7zwpZ2IDfk4URESmfDTiy95jf856Hcwzdxfy
jdwx0k7n4/0WK9ElybN4J95sgeGRcqd4pji6171bREVt0UlHrIRkftIMFK1bzU0dgpgLMu+ykJSE
0Bog41D9T6Swl2RTuKYYO4UAl9nSjWN6CVP8rZQotJv8Kl2llpe83n6ULzNfe2QT67IB5sJdsrNk
jIxSwaWjOUNddWvCk/b5qsVUROOuctPyYnAFTU5KY5qhyuiFTvvVlOMArFkStNlVKIufop5EQh6p
jqDGT6rp4ANDoEWbHKd4mwrMtvrh51/8UzaJrLzj3GjdkJ/sPWkDbn+AIt6lrO8hbYSD8L7RQDqK
C28FheVr4ynpkrWkT7Rl6npWhyumaCbjR+8bo9gs7rto9SPDhWhgPSR9R1//WF3mdHt8SKERhvtd
NFkE3zf36V9Vnu0EO1ay2n5imrOfLkOVF3vtAjleJnesM/R7v5tMS0tWoIr39KaQNURwI//WVuR+
zjqIQVx5s7Ta1GgEL56z0C5GJoNE1LvGXnQDyvDO6QeJVThFNgwkossyvmMAaPOJYnYCrYXiXXle
A6TpL63Gu8foNftUO0T83JbV/e6J8iCOnGZwZDrubOtYn1QwggWDMIIDa6ADAgECAg5F5rsDgzPD
hWVI5v9FUTANBgkqhkiG9w0BAQwFADBMMSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBS
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
h7+XeQIDAQABo4IB4TCCAd0wHwYDVR0RBBgwFoEUc3JvZXR0Z2VyQGdvb2dsZS5jb20wDgYDVR0P
AQH/BAQDAgWgMB0GA1UdJQQWMBQGCCsGAQUFBwMEBggrBgEFBQcDAjAdBgNVHQ4EFgQUIEpk9LeP
wpMLMTu4xw9aIS2QlFowWAYDVR0gBFEwTzAJBgdngQwBBQECMEIGCisGAQQBoDIKAwMwNDAyBggr
BgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/
BAIwADCBmgYIKwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNp
Z24uY29tL2NhL2dzYXRsYXNyNnNtaW1lY2EyMDIzMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2F0bGFzcjZzbWltZWNhMjAyMy5jcnQwHwYDVR0jBBgw
FoAUM7q+o9Q5TSoZ18hmkmiB/cHGycYwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9i
YWxzaWduLmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMy5jcmwwDQYJKoZIhvcNAQELBQADggIB
AApDzzM7o/eN8y6tOCmrva0+FElFb4/zoAF277X5GF03khnKugiCMeFn1vN99MW0XhoZJX3oaRh/
kbmS4Jj2LFV8VClBhzfwL5KYfH/sp33JPPNqXAM01rMitZrQXHU5tqY6p3EulvDhuPC4O9PDX/RB
j/7S9lPmc8eB1Umt5zlXvFmcnNGBHLcYCfWKk9s8/DR5c8BclxVkoqscbzJT6L62mvEIv70lFC5C
9J7AYkNuTggYm9cLCC+kiCHCpyyld5oJbau9hryoqMh9GfcWsNTnF4DGK5SIqoplZBgXxw4mIHAk
LLXkkKi7hKxZAKaRLu6y3jouwXUGiMStgC6ZTgk05furxFDeXlF1xPiGYQGrWwmFSmrl2VDONMiM
/2l67XlRE4c7Eag/NJGNfKfMMQjVphorgdhNyvrfhIzJo3aJZAYc6xGOa/ObV0u81/AjUzC55xgM
UsapgQb+TdlJ7havnEkSxesmJ+9MFam1PCs6cyD0cfB6N9akW90nwNkSejnXYHe9tgpbJiEtYkUP
lR/qhSb5ipklyojPo2pDsi3HETfhI+grb6TDsf3vB0i5VcX2fj0/MXb84fI9w2UwgVzgUDdEFLiq
41TOWJNyQDtWMiHUyUZE9yIDF/Ek6kW5/U1YdupxrUyF3ht5eHy0UTyuATYviB5b5H6Jz3Ho4MgK
MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEq
MCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSNiBTTUlNRSBDQSAyMDIzAhABzzfGllVWiQacWdZL
F/BxMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBEgWyqFgBVJPnOPvXRIb4+q61M
1FPZ4HqIJlasaJletTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0y
NDEwMjIxMDQxMDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzALBglghkgB
ZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAg+b42/ln41XCwo58V1KtwXYCiEaPp6VsMIwHCDnYmuky
IOFlIZdVn7vsPA/04xZ8m7/Rl8i/SZGmHbq4H4FVT6NdDAH4zo0SKSo/d9h5P3A2/k9ZeAbtNz4W
HpgWDi8SZD9Oto1spa2CsaOh7pnyoxvR+71D6+WY0w1Yal192Ly3iXx/N+BVRxB6WCpqHABOJynu
s63nevNhPaeJU/aei1W33Y2tF8OT+8USBZ4+X8bSimx7KljgcffjC2u+tswjaiplZk1UahT4ynF3
euI/bRE+K2eMTTBhEQJ9ynXkCBKIhYoX0jsNMwXsXGSSgBwVAN0Vxq6AwJ3WvBtp8e8/ZA==
--000000000000ddf27706250e676f--

