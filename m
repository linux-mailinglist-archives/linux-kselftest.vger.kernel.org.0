Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE681E9C5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 20:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfD2SMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 14:12:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46460 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfD2SMc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 14:12:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id k18so8591719lfj.13
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rSXrLueo+dlB0QOA/Bz3QN8ayKh59Nj+1c63WoQALY=;
        b=BGgMKVPsvqNoV6+19qjq9PyjRoQcgSyZoqJJgWGli2u+TA0JhPmNLWxVZNZngOTh0Z
         bBbwt+/UwMXmo/5/P88lqtFZDjNDADrto7uZEZhKt3oRPWdU9IZgxI3xIN6kYaaq5rjS
         q9ZRgMmDVcReuUcQT1NEHybGemWu/Bnwa48X8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4rSXrLueo+dlB0QOA/Bz3QN8ayKh59Nj+1c63WoQALY=;
        b=IpHOa4aPjBUvHabBACWXd2esMJblLWoAPKza8HLCwmRC4Vh7X6U2djdhVM/JrGjS0Y
         8hrtUr8neQSF+ijmWGwvdr42XcON1qMPGTBamYVvY30bRE4d5/8tVzrqzPVGSpbKlOtg
         ed+fsx+NT7AFkdNpD06OvuPshy/ecYNFWPGPoqfy05bz2RSMCzPjpSV6cb1KKH650HZ8
         GsRZVnI5l+ecX0Pe9b6iHglCMdeNFb6K1C3CBxsPQTCt0AptILVrsCDrbXG+GUEhlmyn
         ycKdeo4zdkI8UgGY2NohX6zffBEE4WZ3ITwxiF5k9EH0MHDYQR8pTLWI2/yVq8C/iEAN
         oHOQ==
X-Gm-Message-State: APjAAAXH+pTGt15fMrXk1k2sEtogOjgfZuF1M3vDqNaM0GQxZAyqVDDg
        zgYn3i1siakwwpZanRaUhrtOuCoN+ts=
X-Google-Smtp-Source: APXvYqxowU09iS0H9f+UinA8PQv9u5z9ZljCI06Nq8v/Ml6qeF0sDUO/BTCoczKo9UD+MJ5OiSs/Nw==
X-Received: by 2002:a19:2814:: with SMTP id o20mr32894694lfo.117.1556561549161;
        Mon, 29 Apr 2019 11:12:29 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z16sm8827301lfi.9.2019.04.29.11.12.28
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 11:12:28 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id j11so8771112lfm.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2019 11:12:28 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id v192mr32479159lfa.136.1556561234549;
 Mon, 29 Apr 2019 11:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190427100639.15074-1-nstange@suse.de> <20190427100639.15074-4-nstange@suse.de>
 <20190427102657.GF2623@hirez.programming.kicks-ass.net> <20190428133826.3e142cfd@oasis.local.home>
In-Reply-To: <20190428133826.3e142cfd@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 11:06:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
Message-ID: <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007504920587af2741"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--0000000000007504920587af2741
Content-Type: text/plain; charset="UTF-8"

On Sun, Apr 28, 2019 at 10:38 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> For optimization reasons, if there's only a single user of a function
> it gets its own trampoline that sets up the call to its callback and
> calls that callback directly:

So this is the same issue as the static calls, and it has exactly the
same solution.

Which I already outlined once, and nobody wrote the code for.

So here's a COMPLETELY UNTESTED patch that only works (_if_ it works) for

 (a) 64-bit

 (b) SMP

but that's just because I've hardcoded the percpu segment handling.

It does *not* emulate the "call" in the BP handler itself, instead if
replace the %ip (the same way all the other BP handlers replace the
%ip) with a code sequence that just does

        push %gs:bp_call_return
        jmp *%gs:bp_call_target

after having filled in those per-cpu things.

The reason they are percpu is that after the %ip has been changed, the
target CPU goes its merry way, and doesn't wait for the text--poke
semaphore serialization. But since we have interrupts disabled on that
CPU, we know that *another* text poke won't be coming around and
changing the values.

THIS IS ENTIRELY UNTESTED! I've built it, and it at least seems to
build, although with warnings

  arch/x86/kernel/alternative.o: warning: objtool:
emulate_call_irqoff()+0x9: indirect jump found in RETPOLINE build
  arch/x86/kernel/alternative.o: warning: objtool:
emulate_call_irqon()+0x8: indirect jump found in RETPOLINE build
  arch/x86/kernel/alternative.o: warning: objtool:
emulate_call_irqoff()+0x9: sibling call from callable instruction with
modified stack frame
  arch/x86/kernel/alternative.o: warning: objtool:
emulate_call_irqon()+0x8: sibling call from callable instruction with
modified stack frame

that will need the appropriate "ignore this case" annotations that I didn't do.

Do I expect it to work? No. I'm sure there's some silly mistake here,
but the point of the patch is to show it as an example, so that it can
actually be tested.

With this, it should be possible (under the text rewriting lock) to do

        replace_call(callsite, newcallopcode, callsize, calltargettarget);

to do the static rewriting of the call at "callsite" to have the new
call target.

And again. Untested. But doesn't need any special code in the entry
path, and the concept is simple even if there are probably stupid bugs
just because it's entirely untested.

Oh, and did I mention that I didn't test this?

                Linus

--0000000000007504920587af2741
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jv2o33gb0>
X-Attachment-Id: f_jv2o33gb0

IGFyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jIHwgNTQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyks
IDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZl
LmMgYi9hcmNoL3g4Ni9rZXJuZWwvYWx0ZXJuYXRpdmUuYwppbmRleCA5YTc5Yzc4MDhmOWMuLjky
YjU5OTU4Y2ZmMyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMKKysr
IGIvYXJjaC94ODYva2VybmVsL2FsdGVybmF0aXZlLmMKQEAgLTczOSw3ICs3MzksMTEgQEAgc3Rh
dGljIHZvaWQgZG9fc3luY19jb3JlKHZvaWQgKmluZm8pCiB9CiAKIHN0YXRpYyBib29sIGJwX3Bh
dGNoaW5nX2luX3Byb2dyZXNzOwotc3RhdGljIHZvaWQgKmJwX2ludDNfaGFuZGxlciwgKmJwX2lu
dDNfYWRkcjsKK3N0YXRpYyB2b2lkICpicF9pbnQzX2hhbmRsZXJfaXJxb2ZmLCAqYnBfaW50M19o
YW5kbGVyX2lycW9uLCAqYnBfaW50M19hZGRyOworc3RhdGljIHZvaWQgKmJwX2ludDNfY2FsbF90
YXJnZXQsICpicF9pbnQzX2NhbGxfcmV0dXJuOworCitzdGF0aWMgREVGSU5FX1BFUl9DUFUodm9p
ZCAqLCBicF9jYWxsX3JldHVybik7CitzdGF0aWMgREVGSU5FX1BFUl9DUFUodm9pZCAqLCBicF9j
YWxsX3RhcmdldCk7CiAKIGludCBwb2tlX2ludDNfaGFuZGxlcihzdHJ1Y3QgcHRfcmVncyAqcmVn
cykKIHsKQEAgLTc2Miw3ICs3NjYsMjIgQEAgaW50IHBva2VfaW50M19oYW5kbGVyKHN0cnVjdCBw
dF9yZWdzICpyZWdzKQogCQlyZXR1cm4gMDsKIAogCS8qIHNldCB1cCB0aGUgc3BlY2lmaWVkIGJy
ZWFrcG9pbnQgaGFuZGxlciAqLwotCXJlZ3MtPmlwID0gKHVuc2lnbmVkIGxvbmcpIGJwX2ludDNf
aGFuZGxlcjsKKwlyZWdzLT5pcCA9ICh1bnNpZ25lZCBsb25nKSBicF9pbnQzX2hhbmRsZXJfaXJx
b247CisKKwkvKgorCSAqIElmIHdlIHdhbnQgYW4gaXJxb2ZmIGlycTMgaGFuZGxlciwgYW5kIGlu
dGVycnVwdHMgd2VyZQorCSAqIG9uLCB3ZSB0dXJuIHRoZW0gb2ZmIGFuZCB1c2UgdGhlIHNwZWNp
YWwgaXJxb2ZmIGhhbmRsZXIKKwkgKiBpbnN0ZWFkLgorCSAqLworCWlmIChicF9pbnQzX2hhbmRs
ZXJfaXJxb2ZmKSB7CisJCXRoaXNfY3B1X3dyaXRlKGJwX2NhbGxfdGFyZ2V0LCBicF9pbnQzX2Nh
bGxfdGFyZ2V0KTsKKwkJdGhpc19jcHVfd3JpdGUoYnBfY2FsbF9yZXR1cm4sIGJwX2ludDNfY2Fs
bF9yZXR1cm4pOworCisJCWlmIChyZWdzLT5mbGFncyAmIFg4Nl9FRkxBR1NfSUYpIHsKKwkJCXJl
Z3MtPmZsYWdzICY9IH5YODZfRUZMQUdTX0lGOworCQkJcmVncy0+aXAgPSAodW5zaWduZWQgbG9u
ZykgYnBfaW50M19oYW5kbGVyX2lycW9mZjsKKwkJfQorCX0KIAogCXJldHVybiAxOwogfQpAQCAt
NzkyLDcgKzgxMSw3IEBAIHZvaWQgKnRleHRfcG9rZV9icCh2b2lkICphZGRyLCBjb25zdCB2b2lk
ICpvcGNvZGUsIHNpemVfdCBsZW4sIHZvaWQgKmhhbmRsZXIpCiB7CiAJdW5zaWduZWQgY2hhciBp
bnQzID0gMHhjYzsKIAotCWJwX2ludDNfaGFuZGxlciA9IGhhbmRsZXI7CisJYnBfaW50M19oYW5k
bGVyX2lycW9uID0gaGFuZGxlcjsKIAlicF9pbnQzX2FkZHIgPSAodTggKilhZGRyICsgc2l6ZW9m
KGludDMpOwogCWJwX3BhdGNoaW5nX2luX3Byb2dyZXNzID0gdHJ1ZTsKIApAQCAtODMwLDcgKzg0
OSwzNiBAQCB2b2lkICp0ZXh0X3Bva2VfYnAodm9pZCAqYWRkciwgY29uc3Qgdm9pZCAqb3Bjb2Rl
LCBzaXplX3QgbGVuLCB2b2lkICpoYW5kbGVyKQogCSAqIHRoZSB3cml0aW5nIG9mIHRoZSBuZXcg
aW5zdHJ1Y3Rpb24uCiAJICovCiAJYnBfcGF0Y2hpbmdfaW5fcHJvZ3Jlc3MgPSBmYWxzZTsKKwli
cF9pbnQzX2hhbmRsZXJfaXJxb2ZmID0gTlVMTDsKIAogCXJldHVybiBhZGRyOwogfQogCitleHRl
cm4gYXNtbGlua2FnZSB2b2lkIGVtdWxhdGVfY2FsbF9pcnFvbih2b2lkKTsKK2V4dGVybiBhc21s
aW5rYWdlIHZvaWQgZW11bGF0ZV9jYWxsX2lycW9mZih2b2lkKTsKKworYXNtKAorCSIudGV4dFxu
IgorCSIuZ2xvYmFsIGVtdWxhdGVfY2FsbF9pcnFvZmZcbiIKKwkiLnR5cGUgZW11bGF0ZV9jYWxs
X2lycW9mZiwgQGZ1bmN0aW9uXG4iCisJImVtdWxhdGVfY2FsbF9pcnFvZmY6XG5cdCIKKwkJInB1
c2ggJWdzOmJwX2NhbGxfcmV0dXJuXG5cdCIKKwkJInN0aVxuXHQiCisJCSJqbXAgKiVnczpicF9j
YWxsX3RhcmdldFxuIgorCSIuc2l6ZSBlbXVsYXRlX2NhbGxfaXJxb2ZmLCAuLWVtdWxhdGVfY2Fs
bF9pcnFvZmZcbiIKKworCSIuZ2xvYmFsIGVtdWxhdGVfY2FsbF9pcnFvblxuIgorCSIudHlwZSBl
bXVsYXRlX2NhbGxfaXJxb24sIEBmdW5jdGlvblxuIgorCSJlbXVsYXRlX2NhbGxfaXJxb246XG5c
dCIKKwkJInB1c2ggJWdzOmJwX2NhbGxfcmV0dXJuXG5cdCIKKwkJImptcCAqJWdzOmJwX2NhbGxf
dGFyZ2V0XG4iCisJIi5zaXplIGVtdWxhdGVfY2FsbF9pcnFvbiwgLi1lbXVsYXRlX2NhbGxfaXJx
b25cbiIKKwkiLnByZXZpb3VzXG4iKTsKKwordm9pZCByZXBsYWNlX2NhbGwodm9pZCAqYWRkciwg
Y29uc3Qgdm9pZCAqb3Bjb2RlLCBzaXplX3QgbGVuLCB2b2lkICp0YXJnZXQpCit7CisJYnBfaW50
M19jYWxsX3RhcmdldCA9IHRhcmdldDsKKwlicF9pbnQzX2NhbGxfcmV0dXJuID0gYWRkciArIGxl
bjsKKwlicF9pbnQzX2hhbmRsZXJfaXJxb2ZmID0gZW11bGF0ZV9jYWxsX2lycW9mZjsKKwl0ZXh0
X3Bva2VfYnAoYWRkciwgb3Bjb2RlLCBsZW4sIGVtdWxhdGVfY2FsbF9pcnFvbik7Cit9Cg==
--0000000000007504920587af2741--
