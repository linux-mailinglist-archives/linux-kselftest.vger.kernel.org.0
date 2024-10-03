Return-Path: <linux-kselftest+bounces-18953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BE998E9D5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 08:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A032818A1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 06:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F836823DF;
	Thu,  3 Oct 2024 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZxmSjezo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360B81AB1
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 06:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727938345; cv=none; b=BRxbg3x0bnMwK7GcTDANJDV/cxI00EOBxojsRIWvFXcWs2LtGh76TqttuZDDDSckikX+4rrDYN3Uo/jTYxdHiDWhmxe5nUgCkq8ojzF9VXwmu2vmFKZAD9jgUda9F9USR4M+aJXRCS3LdF6MtYBZzF7UGqMA9i4UCrXf8BPPsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727938345; c=relaxed/simple;
	bh=aWA+Su4GzrubFzLlRa355dlP267ZvwBw3obazTVE2IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcxHubpcYS/TzpV7rKeHLNCT/oDZeORfhmNMafYEkSmjxebl2tWyuLvWpltZlTXndPHeaR5UCtn4FSX7zs4Np0JYRS9qVJtpkwzXu8Rmzia6aYpVvpaTXylabLbu4Vf0qOOgck0H3OF+IHdAMO6Zb1OBCthDReW2oY3cbJ+4X14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZxmSjezo; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6c5acb785f2so3619246d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Oct 2024 23:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727938343; x=1728543143; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aouNe6yH5/A1d/PEKDAxlv/dJ/0z7ySUFi+MDO5aoWU=;
        b=ZxmSjezonMN3PfeNBn23hQoARhVbXmjlfNulX/Ct5Jx5fFzaQEPwNPKvmZmn6rK5ow
         Hwiuj3nBM8foHEsXNU42/4X8n2YX7s6axcwO/THTS77PXYsmYY7ON97LVei7vg1P3l+w
         lBdjms6YbOwjD8NNFoFx2LjSDahX1F0G/WSZFzK3dJiPiw2/iAiLhA2aFfCj119Af50B
         1EeD7Y5k1AZtamakGQm8DIgewPLolTo1YiD7LHA/EKL4UkfIeEKMnaWEcB4jxELYFvPq
         PQfr/DoNkbdwI/3zZOyv6hT9CH/JTLWpG4H/Q8YcjkIzcGSeaqX4mDn2EIDaMoDGfmEL
         54yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727938343; x=1728543143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aouNe6yH5/A1d/PEKDAxlv/dJ/0z7ySUFi+MDO5aoWU=;
        b=IROGFFX0J8/BSavksVXHFpO356FZC3PFq6ZMJZogdk3JWmcQmy++NdjJwC2XuF/EOX
         GOoIs2hD4hige5kEJAECB9ATMK2BGlPUkKmHlYDvXGTeab46ewROTbwH5Zhpiq2u1Nem
         V0j6BaZOAb3mKdiPhprK/v6kS3pgxYvkfnArB7Wx7SreVirSSW4HhpW5ygYeE67engk3
         Y2NuYg8WJ3g2RQ0K52BPLFqxgVZg4Js6v1JQj5iv43Z1VEqXOSzeprzFCIeMBkibJ7Gq
         7V6z/HkA4DyvvIziHbUrxlYmhgWcPc5PQXJl6BGN7tITkQXIbew0giOkQ7LhYN7pQqvW
         4hGg==
X-Forwarded-Encrypted: i=1; AJvYcCV3MI2PHpldeeR/F5TxPoM/PDl+ZU/e3VOiiCq6MNHyDK81UJDgHqQpAWzfZP5HwGDvGM+7qO+aM47TC3jCF5s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq9wWAPiOkt0YarCJ4ZU9QO7aF0AD5TipZeueKRWSPR02yRDIj
	seLbV0myq/Z4lk3LA88fXpXEDmiNrrI6uajLpRqHAiFdQ8sr+6C//v1lfIvWrCOIAziWIZOPb0l
	T3BlCf2zRbeB24I0yR4OLS71yyPb4AQ1va6Pl
X-Google-Smtp-Source: AGHT+IHhxG8s8ItijTps88fFJLz8xQb6cCNhASYpJNvFv+ZfK4juq/0SlfazKvQBC0lKIpizCOIcXdvl6455ahg22iI=
X-Received: by 2002:a05:6214:3bca:b0:6cb:3ba5:79e1 with SMTP id
 6a1803df08f44-6cb819b2c12mr80871086d6.11.1727938342540; Wed, 02 Oct 2024
 23:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930-b4-slub-kunit-fix-v1-0-32ca9dbbbc11@suse.cz>
 <20240930-b4-slub-kunit-fix-v1-2-32ca9dbbbc11@suse.cz> <9dd56c26-12db-4b69-af0e-fdea33bb8208@roeck-us.net>
 <ee52f8af-ef1a-4382-ab9a-f9781157d1be@roeck-us.net>
In-Reply-To: <ee52f8af-ef1a-4382-ab9a-f9781157d1be@roeck-us.net>
From: David Gow <davidgow@google.com>
Date: Thu, 3 Oct 2024 14:52:11 +0800
Message-ID: <CABVgOSkhwCoeV_1YCOnGatCGWwZ62Oa8dZ_VzZ+qtPixzw5NfQ@mail.gmail.com>
Subject: Re: [PATCH slab hotfixes 2/2] kunit: move call to kunit_run_all_tests()
 after rcu_end_inkernel_boot()
To: Guenter Roeck <linux@roeck-us.net>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org, Rae Moar <rmoar@google.com>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	Brendan Higgins <brendan.higgins@linux.dev>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000021d05706238cff81"

--00000000000021d05706238cff81
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Oct 2024 at 07:55, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/30/24 11:50, Guenter Roeck wrote:
> > On 9/30/24 01:37, Vlastimil Babka wrote:
> >> Guenter Roeck reports that the new slub kunit tests added by commit
> >> 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and
> >> test_leak_destroy()") cause a lockup on boot on several architectures
> >> when the kunit tests are configured to be built-in and not modules.
> >>
> >> These tests invoke kfree_rcu() and kvfree_rcu_barrier() and boot
> >> sequence inspection showed the runner for built-in kunit tests
> >> kunit_run_all_tests() is called before setting system_state to
> >> SYSTEM_RUNNING and calling rcu_end_inkernel_boot(), so this seems like a
> >> likely cause. So while I was unable to reproduce the problem myself,
> >> moving the call to kunit_run_all_tests() a bit later in the boot seems
> >> to have fixed the lockup problem according to Guenter's limited testing.
> >>
> >> No kunit tests should be broken by calling the built-in executor a bit
> >> later, as when compiled as modules, they are still executed even later
> >> than this.
> >>
>
> Actually, that is wrong.
>
> Turns out kunit_iov_iter (and other kunit tests) are marked __init.
> That means those unit tests have to run before the init code is released,
> and it actually _is_ harmful to run the tests after rcu_end_inkernel_boot()
> because at that time free_initmem() has already been called.

Yeah: some tests are marked __init. KUnit does actually mark these
with an attribute, so we can potentially split the execution up into
an 'init' part which runs early, and a later part, but there are some
complications if we still want to track the total number of tests and
support filtering, etc. properly.

That's something I think we'll look at for 6.13: in the meantime,
skipping the problematic slub tests when built-in seems to be the
right short-term fix. I'll look into having the built-in executor
moved later for non-init tests once we've worked out how best to adapt
the filter/KTAP output code to do so as cleanly as possible.

Cheers,
-- David


>
> Guenter
>
> >> Fixes: 4e1c44b3db79 ("kunit, slub: add test_kfree_rcu() and test_leak_destroy()")
> >> Reported-by: Guenter Roeck <linux@roeck-us.net>
> >> Closes: https://lore.kernel.org/all/6fcb1252-7990-4f0d-8027-5e83f0fb9409@roeck-us.net/
> >> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> >> Cc: Boqun Feng <boqun.feng@gmail.com>
> >> Cc: Uladzislau Rezki <urezki@gmail.com>
> >> Cc: rcu@vger.kernel.org
> >> Cc: Brendan Higgins <brendanhiggins@google.com>
> >> Cc: David Gow <davidgow@google.com>
> >> Cc: Rae Moar <rmoar@google.com>
> >> Cc: linux-kselftest@vger.kernel.org
> >> Cc: kunit-dev@googlegroups.com
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>   init/main.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/init/main.c b/init/main.c
> >> index c4778edae7972f512d5eefe8400075ac35a70d1c..7890ebb00e84b8bd7bac28923fb1fe571b3e9ee2 100644
> >> --- a/init/main.c
> >> +++ b/init/main.c
> >> @@ -1489,6 +1489,8 @@ static int __ref kernel_init(void *unused)
> >>       rcu_end_inkernel_boot();
> >> +    kunit_run_all_tests();
> >> +
> >>       do_sysctl_args();
> >>       if (ramdisk_execute_command) {
> >> @@ -1579,8 +1581,6 @@ static noinline void __init kernel_init_freeable(void)
> >>       do_basic_setup();
> >> -    kunit_run_all_tests();
> >> -
> >>       wait_for_initramfs();
> >>       console_on_rootfs();
> >>
> > Unfortunately it doesn't work. With this patch applied, I get many backtraces
> > similar to the following, and ultimately the image crashes. This is with arm64.
> > I do not see the problem if I drop this patch.
> >
> > Guenter
> >
> > ---
> > [    9.465871]     KTAP version 1
> > [    9.465964]     # Subtest: iov_iter
> > [    9.466056]     # module: kunit_iov_iter
> > [    9.466115]     1..12
> > [    9.467000] Unable to handle kernel paging request at virtual address ffffc37db5c9f26c
> > [    9.467244] Mem abort info:
> > [    9.467332]   ESR = 0x0000000086000007
> > [    9.467454]   EC = 0x21: IABT (current EL), IL = 32 bits
> > [    9.467576]   SET = 0, FnV = 0
> > [    9.467667]   EA = 0, S1PTW = 0
> > [    9.467762]   FSC = 0x07: level 3 translation fault
> > [    9.467912] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000042a59000
> > [    9.468055] [ffffc37db5c9f26c] pgd=0000000000000000, p4d=1000000044b36003, pud=1000000044b37003, pmd=1000000044b3a003, pte=0000000000000000
> > [    9.469430] Internal error: Oops: 0000000086000007 [#1] PREEMPT SMP
> > [    9.469687] Modules linked in:
> > [    9.470035] CPU: 0 UID: 0 PID: 550 Comm: kunit_try_catch Tainted: G                 N 6.12.0-rc1-00005-ga65e3eb58cdb #1
> > [    9.470290] Tainted: [N]=TEST
> > [    9.470356] Hardware name: linux,dummy-virt (DT)
> > [    9.470530] pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    9.470656] pc : iov_kunit_copy_to_kvec+0x0/0x334
> > [    9.471055] lr : kunit_try_run_case+0x6c/0x15c
> > [    9.471145] sp : ffff800080883de0
> > [    9.471210] x29: ffff800080883e20 x28: 0000000000000000 x27: 0000000000000000
> > [    9.471376] x26: 0000000000000000 x25: 0000000000000000 x24: ffff80008000bb68
> > [    9.471501] x23: ffffc37db3f7093c x22: ffff80008000b940 x21: ffff545847af4c00
> > [    9.471622] x20: ffff545847cd3940 x19: ffff80008000bb50 x18: 0000000000000006
> > [    9.471742] x17: 6c61746f7420303a x16: 70696b7320303a6c x15: 0000000000000172
> > [    9.471863] x14: 0000000000020000 x13: 0000000000000000 x12: ffffc37db6a600c8
> > [    9.471983] x11: 0000000000000043 x10: 0000000000000043 x9 : 1fffffffffffffff
> > [    9.472122] x8 : 00000000ffffffff x7 : 000000001040d4fd x6 : ffffc37db70c3810
> > [    9.472243] x5 : 0000000000000000 x4 : ffffffffc4653600 x3 : 000000003b9ac9ff
> > [    9.472363] x2 : 0000000000000001 x1 : ffffc37db5c9f26c x0 : ffff80008000bb50
> > [    9.472572] Call trace:
> > [    9.472636]  iov_kunit_copy_to_kvec+0x0/0x334
> > [    9.472740]  kunit_generic_run_threadfn_adapter+0x28/0x4c
> > [    9.472835]  kthread+0x11c/0x120
> > [    9.472903]  ret_from_fork+0x10/0x20
> > [    9.473146] Code: ???????? ???????? ???????? ???????? (????????)
> > [    9.473505] ---[ end trace 0000000000000000 ]---
> >
>

--00000000000021d05706238cff81
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIUqgYJKoZIhvcNAQcCoIIUmzCCFJcCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghIEMIIGkTCCBHmgAwIBAgIQfofDAVIq0iZG5Ok+mZCT2TANBgkqhkiG9w0BAQwFADBMMSAwHgYD
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
erg7AgMBAAGjggHgMIIB3DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1UdDwEB
/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFKFQnbTpSq0q
cOYnlrbegXJIIvA6MFgGA1UdIARRME8wCQYHZ4EMAQUBAjBCBgorBgEEAaAyCgMDMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQC
MAAwgZoGCCsGAQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWdu
LmNvbS9jYS9nc2F0bGFzcjZzbWltZWNhMjAyMzBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5n
bG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3J0MB8GA1UdIwQYMBaA
FDO6vqPUOU0qGdfIZpJogf3BxsnGMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vY2EvZ3NhdGxhc3I2c21pbWVjYTIwMjMuY3JsMA0GCSqGSIb3DQEBCwUAA4ICAQBR
nRJBmUP+IpudtmSQ/R55Sv0qv8TO9zHTlIdsIf2Gc/zeCi0SamUQkFWb01d7Q+20kcpxNzwV6M7y
hDRk5uuVFvtVxOrmbhflCo0uBpD9vz/symtfJYZLNyvSDi1PIVrwGNpyRrD0W6VQJxzzsBTwsO+S
XWN3+x70+QDf7+zovW7KF0/y8QYD6PIN7Y9LRUXct0HKhatkHmO3w6MSJatnqSvsjffIwpNecUMo
h10c6Etz17b7tbGdxdxLw8njN+UnfoFp3v4irrafB6jkArRfsR5TscZUUKej0ihl7mXEKUBmClkP
ndcbXHFxS6WTkpjvl7Jjja8DdWJSJmdEWUnFjnQnDrqLqvYjeVMS/8IBF57eyT6yEPrMzA+Zd+f5
hnM7HuBSGvVHv+c/rlHVp0S364DBGXj11obl7nKgL9D59QwC5/kNJ1whoKwsATUSepanzALdOTn3
BavXUVE38e4c90il44T1bphqtLfmHZ1T5ZwxjtjzNMKy0Mb9j/jcFxfibCISYbnk661FBe38bhYj
0DhqINx2fw0bwhpfFGADOZDe5DVhI7AIW/kEMHuIgAJ/HPgyn1+tldOPWiFLQbTNNBnfGv9sDPz0
hWV2vSAXq35i+JS06BCkbGfE5ci6zFy4pt8fmqMGKFH/t3ELCTYo116lqUTDcVC8DAWN8E55aDGC
AmowggJmAgEBMGgwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKjAo
BgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjYgU01JTUUgQ0EgMjAyMwIQAZ6Vqszmp/3gGFW0sCFu
eDANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgqgwbQBDR1ZnBhuSbns4SsepiM7At
mXJOwXGC+8gUyk8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQx
MDAzMDY1MjIzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgBZQMEARYwCwYJ
YIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcwCwYJYIZIAWUD
BAIBMA0GCSqGSIb3DQEBAQUABIIBAGZW/jgKnwXsh2DGuhEt3sPQZCIIa6Fpg9Swc11pd5huUDKZ
kPY7rArqANj9qf5HcdpzWSBpJcwAORCW2rhFdlMBrF5uIvgY4DpZ1wdhwcsoV1o6dIiVgHHZsnr3
eEfn2eOhfTsyYD3T961VdQ1VmdAg1dtrvSaqo0kPxG4c3pVmZStFXMMZe3NX/zLkBsVypnfEtCp4
9Uy5A5yyvfpBvBTfFfAgC4rP5k1EDMhE1Jqk9cqm5bsPFo72UTDKiHBDN/GwRoZGbwr+Eocwyxzz
Kw7+FeusqHdkSWwtWjqrzdIr+f1RkDPlJnv4oSTdTEDw80oaBJufQ76B4s5Lh+WbBXs=
--00000000000021d05706238cff81--

