Return-Path: <linux-kselftest+bounces-450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A7E7F4E31
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 18:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC1628142B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5895B5A1;
	Wed, 22 Nov 2023 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="djW0rCp2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A61A8
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 09:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700673581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9F8luSkLS94qknN9g2F0Qlv/PMDhatpz5xR+p0UaIM=;
	b=djW0rCp2Qw834F4meiDGcBY3PQVi7H0L9ACbNd5wjGOe/CA4k4Ocf36gsU2q5ePw5KR5Ye
	SsXCMmUN8h69c6H/0421jy5+Nfd6zsvZOZo5r/fGayMstin8zALsMXri1ZJ94t6cozGOK+
	kLHHg/w+WqUFyaYBgiYes/6zYATbFEY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-MAylD2iwNoaR-_uKCKrwwg-1; Wed, 22 Nov 2023 12:19:39 -0500
X-MC-Unique: MAylD2iwNoaR-_uKCKrwwg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-778b5445527so220578585a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Nov 2023 09:19:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673579; x=1701278379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q9F8luSkLS94qknN9g2F0Qlv/PMDhatpz5xR+p0UaIM=;
        b=palz9jqesvRQGn5lrgYbsC86fJz7J6asNyP1EH9xUmL/LcE+zKXEPQXVb47nGx7hL8
         NNSAe5M/Iw/jFVnhOKrFq/6A2Q2jl0llrCvZW1sv6K3KIo7lkdpuTeJ6Vg6TzF3+IJwi
         rcP+/DcUFLGiB9eONmj2s3gjeGAIXmSHfSurhOQ/3AiU+xk4fDjdCbZHhKjbEVsS09jL
         T/PoE/ikc7B/DB21jIb0syIO352/u3vLXPBjozJ1R6aDoSybwDWuVfKGIukh9O+asmqe
         hFjqa1FtKp+va5NbOxD1FHQjCB+5HIHBW3Cu0PbpT0swukkt3GQhM+XbuWy/7Z+9K8l2
         l3qA==
X-Gm-Message-State: AOJu0YwOPfia3s1DvMhK5T8EC0HPvRdoUiZLFqOI7FQJwJVO1qjtfFy8
	TZNihfMvvxcQElo/CYF0vMQwrCfmPTp93miekqp3h/wJBsrrkipEOoG+4X126CAO9WkGbIkoka5
	9HMmrePbko4uGARwWXGRhFc49bvVE
X-Received: by 2002:a05:620a:4016:b0:775:8fab:8c6f with SMTP id h22-20020a05620a401600b007758fab8c6fmr138971qko.29.1700673579195;
        Wed, 22 Nov 2023 09:19:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDO7wtI5fmFIqHfIMuXIFc4gNjAlSxlFCQNZ2n72fom71dWUvMJverJqO8D1rkiIZRj+0YiQ==
X-Received: by 2002:a05:620a:4016:b0:775:8fab:8c6f with SMTP id h22-20020a05620a401600b007758fab8c6fmr138945qko.29.1700673578804;
        Wed, 22 Nov 2023 09:19:38 -0800 (PST)
Received: from [192.168.0.118] (88-113-27-52.elisa-laajakaista.fi. [88.113.27.52])
        by smtp.gmail.com with ESMTPSA id az30-20020a05620a171e00b0077d6700a460sm15864qkb.82.2023.11.22.09.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 09:19:38 -0800 (PST)
Message-ID: <61497ab2-d44d-4a7a-984b-d4ded259f583@redhat.com>
Date: Wed, 22 Nov 2023 19:19:34 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Content-Language: en-US
To: David Gow <davidgow@google.com>
Cc: workflows@vger.kernel.org, Joe Perches <joe@perches.com>,
 Andy Whitcroft <apw@canonical.com>, Theodore Ts'o <tytso@mit.edu>,
 Steven Rostedt <rostedt@goodmis.org>, Mark Brown <broonie@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, "Darrick J . Wong"
 <djwong@kernel.org>, kunit-dev@googlegroups.com,
 linux-kselftest@vger.kernel.org, Veronika Kabatova <vkabatov@redhat.com>,
 CKI <cki-project@redhat.com>, kernelci@lists.linux.dev
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
 <CABVgOSkRpL9KC4FDMrQ-g51b0_BB-=m71LzaQNG8UsqHJ7VrkQ@mail.gmail.com>
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
In-Reply-To: <CABVgOSkRpL9KC4FDMrQ-g51b0_BB-=m71LzaQNG8UsqHJ7VrkQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/23 12:36, David Gow wrote:
> Thanks so much for doing this! I think everyone agrees that we need
> _some_ way of documenting which tests to run, and I think this is our
> best option.

Awesome :D

> In any case, this patch does a lot, and I'll comment on them
> one-by-one. (It may be worth splitting this patch up into a few
> separate bits, if only so that we can better separate the
> uncontroversial bits from the open questions.)

Yeah, I'll try to figure out a less controversial split.

> On Thu, 16 Nov 2023 at 01:52, Nikolai Kondrashov
>> Each referenced test suite is expected to be documented in the new
>> Documentation/process/tests.rst file, which must have enough structure
>> (documented inside) for the tools to make use of it. Apart from basic
>> data, each test can refer to its "superset" - a test suite which this
>> one is a part of. The expected use is to describe both a large test
>> suite and its subsets, so the former would also be accepted, if a
>> subsystem requires only a subset.
> 
> I think this could work, but is a bit complicated.
> 
> My initial thought was to have this as a more free-form field, which
> either contained a:
> - Path to a command to run (e.g. tools/testing/kunit/run_checks.py)
> - Path to a documentation file describing the test.
> - URL to a page describing the test
> - (Maybe) freeform text.

I think we should be careful about having too much flexibility here, if we
want to have tools process this. I mean, we would then have to formalize and
define the syntax for all the cases, which could then become too obscure for
humans to easily read and write.

As I said elsewhere, our ultimate (even if unachievable) target should be to
have commands to execute (instead of long setup and execution instructions),
for *all* V: entries. So that definitely should be supported. The current
patch already supports putting a command in the tests.rst to be printed by
checkpatch.pl. Perhaps we can allow putting it into the V: entry directly. I
have one idea on how to do that.

OTOH, I think there's value in an overall catalogue of tests and having
easily-accessible documentation for that command (even if brief), and that's
what going for the command via tests.rst allows.

Regarding a path to the documentation file, that goes against the idea of a
catalogue file, again, so I'm reluctant of letting it go. Same goes for a
documentation URL. Both of these can be expressed via the catalogue too.

I wonder if it could be useful to add another option to get_maintainer.pl, or
implement a new script, which would just dump the referenced test catalogue
sections for a patchset, for a longer-form read than what checkpatch.pl can
produce, but faster than scanning the whole catalogue personally.

> It's probably worth also looking at this proposal to auto-generate
> similar documentation:
> https://lore.kernel.org/linux-kselftest/cover.1689171160.git.mchehab@kernel.org/

IIRC, Mauro has mentioned this effort to me at EOSS in Prague, but I still
haven't found the time to look at it closely. I think this is a worthy effort
overall, but at a somewhat lower level. What I would like to be in the
tests.rst is a basic intro and help to get each corresponding test suite
running, to help breach the gap between trying to contribute and having your
contribution tested with what maintainers prescribe. The docs in tests.rst can
point to the more detailed docs, in turn. I also think it's good to have a
document with an overview of what tests exist in general and which areas they
address.

> The other question is how to handle outdated results when a new patch
> revision is sent out. Personally, I think this is something we can
> solve similarly to 'Reviewed-by', depending on the extent of the
> changes and cost of the tests. I suspect for most automated tests,
> this would mean never carrying the 'Tested-with' tag over, but if
> testing it involved manually building and running kernels against 50
> different hardware setups, I could imagine it making sense to not
> re-do this if a new revision just changed a doc typo. If a URL is used
> here, it could contain version info, too.

Yeah, that would be painful.

> Paste encouragement for in-tree test suites triggered by git forges here <

I think what Ricardo is suggesting in another branch, regarding adding result
URLs, could work. So it would be nice to account for that in the change, but
the policy would probably depend on subsystem/maintainer/the change in question.

>> Introduce a new tag, 'Tested-with:', documented in the
>> Documentation/process/submitting-patches.rst file. The tag is expected
>> to reference the documented test suites, similarly to the 'V:' field,
>> and to certify that the submitter executed the test suite on the change,
>> and that it passed.
> 
> I'm also 100% for this, though I'd considered it separately from the
> MAINTAINERS change.
> 
> I think, in the ideal case, we want this to link to the results
> somehow. kcidb would seem to be the obvious choice there.
> 
> Again, as a fallback, a plain text field would be useful to describe
> cases where a patch was tested by some means other than a formal test
> suite. This might not be ideal, but I'd still rather have people
> describe that something "builds and boots on <x> hardware" than have
> to guess if a patch was tested at all.
> 
> Of course, it'd then be up to maintainers to decide what they'd
> accept: I'd expect that some would require there be a 'Tested-with'
> header which links to valid results for the tests described in
> MAINTAINERS.

I'm thinking that maybe we should just not *require* a valid reference to a
documented test in the Tested-with: field. I.e. only verify that all the V:
values are listed, but ignore everything unknown.

>> Make scripts/checkpatch.pl ensure any added V: fields reference
>> documented test suites only, and output a warning if a change to a
>> subsystem doesn't certify the required test suites were executed,
>> if any.
> 
> I'd definitely want something like this to run at some point in the
> patch-submission workflow. I think that, ultimately, we'll want to be
> able to run some tests automatically (e.g., a git hook could run the
> tests and add the 'Tested-with' line).
> 
> Personally, I'd like to require that all patches have a 'Tested-with'
> field, even if there's not a corresponding 'V' MAINTAINERS entry, as
> people should at least think of how something's tested, even if
> there's not a formal 'test suite' for it. Though that seems a
> longer-term goal

Yeah, that would be nice from a maintainer's POV, but probably not very popular.

>> If the test suite description includes a "Command", then checkpatch.pl
>> will output it as the one executing the suite. The command should run
>> with only the kernel tree and the regular developer environment set up.
>> But, at the same time, could simply output instructions for installing
>> any extra dependencies (or pull some automatically). The idea is to
>> get the developer into feedback loop quicker and easier, so they have
>> something to run and iterate on, even if it involves installing some
>> more stuff first. Therefore it's a good idea to add such wrappers to the
>> kernel tree proper and refer to them from the tests.rst.
>>
>> Extend scripts/get_maintainer.pl to support retrieving the V: fields,
>> and scripts/parse-maintainers.pl to maintain their ordering.
>>
>> Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
>> ---
> 
> The questions I think we need to answer to get this in are:
> 1. Do we want to split this up (and potentially land it
> piece-by-piece), or is it more valuable to have a stricter, more
> complete system from the get-go?

I'll see what I can do about splitting it.

> 2. What format should the 'V' line take? If it is simply a test name,
> do we use a doc as suggested (or one generated in part from some other
> process), or something like a command name or URL? Can it just be
> freeform text?
> 3. Should 'Tested-with' be a test name in the same format as 'V', a
> URL to results (any URL, or just kcidb?), or freeform text? How does
> this evolve with multiple versions of patches?

I don't think it's useful to restrict this to kcidb. I think the tools should
generally allow anything there, but verify the entries by MAINTAINERS are
there, as I write above.

> 4. How should this be enforced? A warning (not an 'error') from
> checkpatch? A separate script?
> 
> Personally, my gut feeling is that we should land the simplest, most
> minimal version of this (the 'V' field, as freeform text) now, and
> build on that as consensus and tooling permits. I'd probably also add
> the 'Tested-with' or similar tag, as freeform text, too. I don't think
> either of those would cause major problems if we needed to change or
> restrict the format later; I imagine there won't be a huge need to
> parse old commits for test data, and even if so, it wouldn't be too
> hard to ignore any which don't conform to any stricter future
> convention.
> 
> But I don't think there's anything fundamentally wrong with the full
> plan as-is, so if everyone's happy with it, I'd not object to having
> it.

I agree that the minimum support (just the freeform V:/Tested-with:) would be
easier to get merged, but would also be somewhat toothless. I think some sort
of test documentation/catalogue adds value, and a message from checkpatch.pl
even more so, as it greatly aids test discoverability, and I is a major point
of the change. We can lower the WARN to INFO to reduce resistance, or even
maybe make the level configurable in the V: field.

Anyway, I'll work on splitting this.

Thanks a lot for the extensive and insightful comments, David!

Nick


