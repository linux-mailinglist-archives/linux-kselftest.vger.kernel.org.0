Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979E170895A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 22:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjERUUx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 16:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjERUUu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 16:20:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E0710D0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 13:20:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50dba8a52dcso2026a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 18 May 2023 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684441244; x=1687033244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTWuRRNk/cl6sDlbBMZskmGX+zk6elTnHmxsNN+hPKI=;
        b=rdm8g1VfSvgnUqlC2P98NKJnhO16smcqE5rlZtC93FgGVUdOwnqPhxBW1aoWXVefas
         NlmhhOfi6kUSpGnQRR32JUlqq7QQbq7nVf8d44+k77elnlG7VRB7WfOC4LLxUt0RmEFO
         r3c+BwOPW5JMd/Pj6FZKqgV67+Xtp1lK+4l1251jlNuhpWsTR9xsKBq64zaNrHtu2/jx
         Ck+gYRhuh8cKvF995++9baMmAtCxMnP3AKVUEGiMw36yXFaIApXBSP5dir+3vSkFp9Ay
         2UtydFJ911sxfhPxw75zc5C2dbqjJ3YJcUCbLJfYgeZM/d7sWU9r44yAwu1Hzq9csPsm
         8HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684441244; x=1687033244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MTWuRRNk/cl6sDlbBMZskmGX+zk6elTnHmxsNN+hPKI=;
        b=Y5gLCvM1gjE0JgduVj2VWQK7If2SvxkOzbe7FhpzGF6Yc8rbboPBFOGJ4zcRhDisag
         X+WgUhQfAhc+QE2I3bzzvhaEFLvXJo6eX+H9T/ije+2JWPxklCMxVnDUZkecpMuCZk4t
         6alYJoszBB1HTtowaipQekhamBM9bpoO3SijOrEZJ40ild+QjycZlGR6J2UdHIpCKKku
         Oe8RaZmJnUuYsQqellokuV6TgInqdpWDYp9+Kj7zgQWf0bY9oK15ckQBiQuIZbnrT+qi
         TnbSk8NGwEnV9H4fj1BBGTA5uUNRa8O4FEPT074GQ7+tdKJDr/NUJ0Fs8Up/YBxp5Nng
         pgpw==
X-Gm-Message-State: AC+VfDzz5qYTubBzcEw9ix5QOFPYtmDkfowUtVWpyYZ3PoVAWvECbdf9
        d1a7U0sHhTiaLrHa1cgRK89bO8wLigREEZ3g/KuOhQ==
X-Google-Smtp-Source: ACHHUZ4szDopDyKvT5uuGOC/RGIO4PSKNo0vEobwjmRHQfdAHmO+IiH6Y82C1wQQUgdrCaYZFjmP9jsUjXLcFNRwos4=
X-Received: by 2002:a50:9ee3:0:b0:50b:f6ce:2f3d with SMTP id
 a90-20020a509ee3000000b0050bf6ce2f3dmr4467edf.0.1684441243652; Thu, 18 May
 2023 13:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <2bcffc9f-9244-0362-2da9-ece230055320@intel.com>
 <CAEAAPHYdRyZEMp97919errF7SDuYBJoSrD5i1wrTx1sMdr_ZdQ@mail.gmail.com>
 <fbe53dcf-6e21-e4cf-c632-4da8369d7e83@intel.com> <CAEAAPHa=zYyjV5RqvPryRsW7VqY9cJC_-CJW6HKczY0iVsy-bg@mail.gmail.com>
 <d8f2d5c2-6650-c2a6-3a20-25583eee579b@intel.com> <CALmYWFsnGjniVseJKuhKO6eet10Onyk_C0=KNe6ZzXoCiBKZOw@mail.gmail.com>
 <b69f6809-b483-158f-8be9-4976fad918d8@intel.com> <CALmYWFs5Vgosz2JUYWkoc4YwDbiB0tT32MFpo-y6aX4kwuoz8Q@mail.gmail.com>
 <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com>
In-Reply-To: <2b14036e-aed8-4212-bc0f-51ec4fe5a5c1@intel.com>
From:   Jeff Xu <jeffxu@google.com>
Date:   Thu, 18 May 2023 13:20:06 -0700
Message-ID: <CALmYWFuSTc5Q7Hrra8FijE11+Y1KiROa=xCZWL1D3ifthrrDMQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Memory Mapping (VMA) protection using PKU - set 1
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>,
        jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Dave,

Thanks for your email.

On Thu, May 18, 2023 at 8:38=E2=80=AFAM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 5/17/23 16:48, Jeff Xu wrote:
> > However, there are a few challenges I have not yet worked through.
> > First, the code needs to track when the first signaling entry occurs
> > (saving the PKRU register to the thread struct) and when it is last
> > returned (restoring the PKRU register from the thread struct).
>
> Would tracking signal "depth" work in the face of things like siglongjmp?
>
Thank you for your question! I am eager to learn more about this area
and I worry about blind spots. I will investigate and get back to you.

> Taking a step back...
>
> Here's my concern about this whole thing: it's headed down a rabbit hole
> which is *highly* specialized both in the apps that will use it and the
> attacks it will mitigate.  It probably *requires* turning off a bunch of
> syscalls (like io_uring) that folks kinda like in general.
>
ChromeOS currently disabled io_uring, but it is not required to do so.
io_uring supports the IORING_OP_MADVICE operation, which calls the
do_madvise() function. This means that io_uring will have the same
pkey checks as the madvice() system call.  From that perspective, we
will fully support io_uring for this feature.

> We're balancing that highly specialized mitigation with a feature that
> add new ABI, touches core memory management code and signal handling.
>
The ABI change uses the existing flag field in pkey_alloc() which is
reserved. The implementation is backward compatible with all existing
pkey usages in both kernel and user space.  Or do you have other
concerns about ABI in mind ?

Yes, you are right about the risk of touching core mm code. To
minimize the risk, I try to control the scope of the change (it is
about 3 lines in mprotect, more in munmap but really just 3 effective
lines from syscall entry). I added new self-tests in mm to make sure
it doesn't regress in api behavior. I run those tests before and after
my kernel code change to make sure the behavior remains the same, I
tested it on 5.15 and 6.1 and 6.4-rc1.  Actually, the testing
discovered a behavior change for mprotect() between 6.1 and 6.4  (not
from this patch, there are refactoring works going on in mm) see this
thread [1]
I hope those steps will help to mitigate the risk.

Agreed on signaling handling is a tough part: what do you think about
the approach (modifying PKRU from saved stack after XSAVE), is there a
blocker ?

> On the x86 side, PKRU is a painfully special snowflake.  It's exposed in
> the "XSAVE" ABIs, but not actually managed *with* XSAVE in the kernel.
> This would be making it an even more special snowflake because it would

I admit I'm quite ignorant on XSAVE  to understand the above
statement, and how that is related. Could you explain it to me please
? And what is in your mind that might improve the situation ?

> need new altstack ABI and handling.
>
I thought adding protected memory support to signaling handling is an
independent project with its own weight. As Jann Horn points out in
[2]:  "we could prevent the attacker from corrupting the signal
context if we can protect the signal stack with a pkey."   However,
the kernel will send SIGSEGV when the stack is protected by PKEY,  so
there is a benefit to make this work.  (Maybe Jann can share some more
thoughts on the benefits)

And I believe we could do this in a way with minimum ABI change, as below:
- allocate PKEY with a new flag (PKEY_ALTSTACK)
- at sigaltstack() call, detect the memory is PKEY_ALTSTACK protected,
(similar as what mprotect does in this patch) and save it along with
stack address/size.
- at signaling handling, use the saved info to fill in PKRU.
The ABI change is similar to PKEY_ENFORCE_API, and there is no
backward compatibility issue.

Will these mentioned help our case ? What do you think ?

(Stephan has more info on gains,  as far as I know, V8 engineers have
worked/thought really hard to come to a suitable solution to make
chrome browser safer)

[1] https://lore.kernel.org/linux-mm/20230516165754.pocx4kaagn3yyw3r@revolv=
er/T/
[2] https://docs.google.com/document/d/1OlnJbR5TMoaOAJsf4hHOc-FdTmYK2aDUI7d=
2hfCZSOo/edit?resourcekey=3D0-v9UJXONYsnG5PlCBbcYqIw#

Thanks!
Best regards,
-Jeff
