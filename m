Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46763709600
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 13:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjESLOQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 07:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjESLOP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 07:14:15 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D829D10C3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 04:14:11 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7841bb211dfso278456241.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 04:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684494851; x=1687086851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vL6IiGLk9SRl+lQ1GxdhhcXh7KfIbbjE5uNAf2+UM5U=;
        b=C0/mhROy3Fik1+kHOFyW5RY506y9sv+wfUZksbhfkXgJWmL9UY7Qo2CbjKQVpU1VG4
         sbBU5y49VIqZS5QSGzE9MHhuddMkYz+tZxXEDBR6ElcKjYHz56DmD8AXwLR3Qshqz/fc
         QxOlJLqBQ3z4XRVTaVbScX1i6LkejITSuqbhR9vmb30zqJJQyXkKon1Yw+vIu3fEWnfR
         Ia5LE4A9PbaaQ1WUoHDmx0ZdqM0QI2eCSc4FwauD8ZFqJPuMuLArbR1grh4nvFgyEVKe
         SE+Zka1ptEt+ed73qDZF169XdLZLnGghUV96mGJ2KDdCf0dll0FgqFmJTbRhQm4/IQJs
         6YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684494851; x=1687086851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vL6IiGLk9SRl+lQ1GxdhhcXh7KfIbbjE5uNAf2+UM5U=;
        b=NbXos0zQ6vrbatwlCLriocvw+KPXW1AxKzhK+qDjyuw7D2S3abgU5qI/huIHUTRJX5
         JQlgvvM3BBbMTCwpbMMrCnZvuESCpuaGuFEbym58038l84VkeCDOknK9uIduPuETrEpp
         UOSPnLB2wcrSiBN4MdYJmG5K1ynTg9uDvLVeup2E5gWOFkUFhNOqHqZBLWZMTcusftQv
         yyDM+qmTdaqFtX+dE0HDPnzRxkY7toeZCGsCUY0RU12gLYi6AKHusiJ8Qy3IHLb2jXU5
         hOdYkvxF7kLmhXE2muqWdZ1Vu6GVKT7YgbCXOBdQlpxg1kheP3fL/EZLU4CazmSNlrFb
         Ieyg==
X-Gm-Message-State: AC+VfDxEVxmKSZgjxOTE2uGAh2/wI3vmrw4dJZFX9fhQ1LlaEKnAgOXr
        PzI9abrhU+C3DgbvivinB+gF0sqoUZmYh7kia5lI9A==
X-Google-Smtp-Source: ACHHUZ72KOKbnc7ZJgRil6BjAK1wv/qki81BuhNCEvX5p3V+Vs2KpLhZ0y4DH8YF6HUV7riSDdvP+OeFzKglqgbG7HA=
X-Received: by 2002:a67:e98c:0:b0:430:16ac:4c99 with SMTP id
 b12-20020a67e98c000000b0043016ac4c99mr461242vso.2.1684494850772; Fri, 19 May
 2023 04:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com> <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com> <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com> <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
 <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com> <CALmYWFuSTc5Q7Hrra8FijE11+Y1KiROa=xCZWL1D3ifthrrDMQ@mail.gmail.com>
 <9d64c949-6d5f-06c0-47ef-caade67477e5@intel.com>
In-Reply-To: <9d64c949-6d5f-06c0-47ef-caade67477e5@intel.com>
From:   =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Date:   Fri, 19 May 2023 13:13:56 +0200
Message-ID: <CAEAAPHYZfzkVex-ET=KnqSkS0rdrMJCza1Uaw1v1nbiXe1_7uA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jeff Xu <jeffxu@google.com>, jeffxu@chromium.org, luto@kernel.org,
        jorgelo@chromium.org, keescook@chromium.org, groeck@chromium.org,
        jannh@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003bbe9c05fc0a053f"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000003bbe9c05fc0a053f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2023 at 11:04=E2=80=AFPM Dave Hansen <dave.hansen@intel.com=
> wrote:
>
> On 5/18/23 13:20, Jeff Xu wrote:>> Here's my concern about this whole
> thing: it's headed down a rabbit hole
> >> which is *highly* specialized both in the apps that will use it and th=
e
> >> attacks it will mitigate.  It probably *requires* turning off a bunch =
of
> >> syscalls (like io_uring) that folks kinda like in general.
> >>
> > ChromeOS currently disabled io_uring, but it is not required to do so.
> > io_uring supports the IORING_OP_MADVICE operation, which calls the
> > do_madvise() function. This means that io_uring will have the same
> > pkey checks as the madvice() system call.  From that perspective, we
> > will fully support io_uring for this feature.
>
> io_uring fundamentally doesn't have the same checks.  The kernel side
> work can be done from an asynchronous kernel thread.  That kernel thread
> doesn't have a meaningful PKRU value.  The register has a value, but
> it's not really related to the userspace threads that are sending it
> requests.
>
> >> We're balancing that highly specialized mitigation with a feature that
> >> add new ABI, touches core memory management code and signal handling.
> >>
> > The ABI change uses the existing flag field in pkey_alloc() which is
> > reserved. The implementation is backward compatible with all existing
> > pkey usages in both kernel and user space.  Or do you have other
> > concerns about ABI in mind ?
>
> I'm not worried about the past, I'm worried any time we add a new ABI
> since we need to support it forever.
>
> > Yes, you are right about the risk of touching core mm code. To
> > minimize the risk, I try to control the scope of the change (it is
> > about 3 lines in mprotect, more in munmap but really just 3 effective
> > lines from syscall entry). I added new self-tests in mm to make sure
> > it doesn't regress in api behavior. I run those tests before and after
> > my kernel code change to make sure the behavior remains the same, I
> > tested it on 5.15 and 6.1 and 6.4-rc1.  Actually, the testing
> > discovered a behavior change for mprotect() between 6.1 and 6.4  (not
> > from this patch, there are refactoring works going on in mm) see this
> > thread [1]
> > I hope those steps will help to mitigate the risk.
> >
> > Agreed on signaling handling is a tough part: what do you think about
> > the approach (modifying PKRU from saved stack after XSAVE), is there a
> > blocker ?
>
> Yes, signal entry and sigreturn are not necessarily symmetric so you
> can't really have a stack.
>
> >> On the x86 side, PKRU is a painfully special snowflake.  It's exposed =
in
> >> the "XSAVE" ABIs, but not actually managed *with* XSAVE in the kernel.
> >> This would be making it an even more special snowflake because it woul=
d
> >
> > I admit I'm quite ignorant on XSAVE  to understand the above
> > statement, and how that is related. Could you explain it to me please
> > ? And what is in your mind that might improve the situation ?
>
> In a nutshell: XSAVE components are classified as either user or
> supervisor.  User components can be modified from userspace and
> supervisor ones only from the kernel.  In general, user components don't
> affect the kernel; the kernel doesn't care what is in ZMM11 (an
> XSAVE-managed register).  That lets us do fun stuff like be lazy about
> when ZMM11 is saved/restored.  Being lazy is good because it give us
> things like faster context switches and KVM VMEXIT handling.
>
> PKRU is a user component, but it affects the kernel when the kernel does
> copy_to/from_user() and friends.  That means that the kernel can't do
> any "fun stuff" with PKRU.  As soon as userspace provides a new value,
> the kernel needs to start respecting it.  That makes PKRU a very special
> snowflake.
>
> So, even though PKRU can be managed by XSAVE, it isn't.  It isn't kept
> in the kernel XSAVE buffer.  But it *IS* in the signal stack XSAVE
> buffer.  You *can* save/restore it with the other XSAVE components with
> ptrace().  The user<->kernel ABI pretends that PKRU is XSAVE managed
> even though it is not.
>
> All of this is special-cased.  There's a ton of code to handle this
> mess.  It's _complicated_.  I haven't even started talking about how
> this interacts with KVM and guests.
>
> How could we improve it?  A time machine would help to either change the
> architecture or have Linux ignore the fact that XSAVE knows anything
> about PKRU.
>
> So, the bar is pretty high for things that want to further muck with
> PKRU.  Add signal and sigaltstack in particular into the fray, and we've
> got a recipe for disaster.  sigaltstack and XSAVE don't really get along
> very well.  https://lwn.net/Articles/862541/
>
> >> need new altstack ABI and handling.
> >>
> > I thought adding protected memory support to signaling handling is an
> > independent project with its own weight. As Jann Horn points out in
> > [2]:  "we could prevent the attacker from corrupting the signal
> > context if we can protect the signal stack with a pkey."   However,
> > the kernel will send SIGSEGV when the stack is protected by PKEY,  so
> > there is a benefit to make this work.  (Maybe Jann can share some more
> > thoughts on the benefits)
> >
> > And I believe we could do this in a way with minimum ABI change, as bel=
ow:
> > - allocate PKEY with a new flag (PKEY_ALTSTACK)
> > - at sigaltstack() call, detect the memory is PKEY_ALTSTACK protected,
> > (similar as what mprotect does in this patch) and save it along with
> > stack address/size.
> > - at signaling handling, use the saved info to fill in PKRU.
> > The ABI change is similar to PKEY_ENFORCE_API, and there is no
> > backward compatibility issue.
> >
> > Will these mentioned help our case ? What do you think ?
>
> To be honest, no.
>
> What you've laid out here is the tip of the complexity iceberg.  There
> are a lot of pieces of the kernel that are not yet factored in.
>
> Let's also remember: protection keys is *NOT* a security feature.  It's
> arguable that pkeys is a square peg trying to go into a round security ho=
le.

While they're not a security feature, they're pretty close to providing us =
with
exactly what we need: per-thread memory permissions that we can use for
in-process isolation.
We've spent quite some effort up front thinking about potential attacks and
we're confident we can build something that will pose a meaningful boundary=
.

> On the x86 side, PKRU is a painfully special snowflake.  It's exposed in
> the "XSAVE" ABIs, but not actually managed *with* XSAVE in the kernel.
> This would be making it an even more special snowflake because it would
> need new altstack ABI and handling.

Most of the complexity in the signal handling proposal seems to come from t=
he
saving/restoring pkru before/after the signal handler execution. However, t=
his
is just nice to have. We just need the kernel to allow us to register
pkey-tagged memory as a sigaltstack, i.e. it shouldn't crash when trying to
write the register state to the stack. Everything else, we can do in userla=
nd.

> It probably *requires* turning off a bunch of
> syscalls (like io_uring) that folks kinda like in general.

Kind of. This approach only works in combination with an effort in userland=
 to
restrict the syscalls. Though that doesn't mean you have to turn them off,
there's also the option of adding validation before it.
The same applies to the memory management syscalls in this patchset. We can=
 add
validation for these in userland, but we're hoping to do it in kernel inste=
ad
for the reasons I mentioned before (e.g. they're very common and it's much
easier to validate in the kernel). Also subjectively it seems like a
nice property
if the pkey protections would not just apply to the memory contents, but al=
so
apply to the metadata.

--0000000000003bbe9c05fc0a053f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPoQYJKoZIhvcNAQcCoIIPkjCCD44CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz7MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
2DeNJUdew/schvbvw4wolIIwTAYDVR0gBEUwQzBBBgkrBgEEAaAyASgwNDAyBggrBgEFBQcCARYm
aHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wDAYDVR0TAQH/BAIwADCBmgYI
KwYBBQUHAQEEgY0wgYowPgYIKwYBBQUHMAGGMmh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2Nh
L2dzYXRsYXNyM3NtaW1lY2EyMDIwMEgGCCsGAQUFBzAChjxodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcnQwHwYDVR0jBBgwFoAUfMwKaNei
6x4schvRzV2Vb4378mMwRgYDVR0fBD8wPTA7oDmgN4Y1aHR0cDovL2NybC5nbG9iYWxzaWduLmNv
bS9jYS9nc2F0bGFzcjNzbWltZWNhMjAyMC5jcmwwDQYJKoZIhvcNAQELBQADggEBAEWztMCBdTNW
CGPLcNM/ovJHsl+VF/BsKdiiwJoodyWO9fmhOgEVex1vfc+njM0bkWC0b4U08iUPP91eksCFGhhi
cCchsXpkAzfcKPJ7OsFd7J4xQUQPpi02r1P7Y9UKLa8nsNChf9ck1GAz1Skb77r1JWgSlHOcyuVZ
UQ/JuUVMf/XW7flFfNybswGgFmfnBvDW1qrqBPHpEFmWeNYXISpFQj0UWyGmykQGKi8q44IPy5Qg
uId+alGaBDlL5OAZQtmhRyh1MVd2wtgvGEfNGDGq603urx17nwEvM1gjSmOgnhEigOhhHH7DOeyt
5zPYLaKguxLWPGXlZ0UUjA7lH3gxggJqMIICZgIBATBoMFQxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFzIFIzIFNNSU1FIENB
IDIwMjACEAGkX4MOebzHzp8Y/d5NuOkwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIE
IBeiU/BGvhzf0gYwkHnlJWueoMRgkjWXA1rmCf9vt2J+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDUxOTExMTQxMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgB
ZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQow
CwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBjFEVEurLW8nTFLUhJ
CikuBheDeZGVHHCa74Co18zaoUx2vEvwiZC7R2lhf8c7WGt3e3IRem79bgX5KV9e6mFW5ehjPN9d
9e5hWnvZ2zmcZTqkoMoE0bcu1LzIK4PR0dh5B8WWPSaqSLoWs2Z/J8+62tIOPIzAXdvoKwIY5Cf9
OJ/uJxepP2Tj3WShrFwr0Xfx8wk7MlNaXlOdhXYXzriPMncToUtSnoFK9dYX0uakUKnN9YpxASZA
OcbIsagj0suj0HMYKin5OW0gok0kmIZXgwYvt5ZfRQtaRvTum+UbyGCd/k2okKpuYSgQGJXi0ygj
SZtQmkmAgzJoDQHTivAE
--0000000000003bbe9c05fc0a053f--
