Return-Path: <linux-kselftest+bounces-21542-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6589BF395
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 17:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDCEE1C22006
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C31DFE33;
	Wed,  6 Nov 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1UswQFQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034F484039
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Nov 2024 16:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911773; cv=none; b=pAOQ3VSswKWU7Fy4uXhag599vUwmeDOHPgojYCKrDLjfV/grOhYhBzTlXIgQR6Y6dZOZybwykj7zRiWZOkQ/TDaK3DCbPAW+922kQgNGorDj1JDieZvj966sTFlYtX+AnrAif+9LvTW6alxL1Kk1Tt+aAdfqNFqOGK3dAjHwRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911773; c=relaxed/simple;
	bh=yvcdIkegWGzoa6Gq0K+tUK5cc03q7hzx+VzG3zVeUjA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=b3cySIhZEmyXmdcdAiMKTioM5FVj1/hbwXc/mw3d1jtb4AphQJ3QEHhXMXfy6ZYseFhGfd3TBUSMoR4fTZ5d49Bdi+rkEsnHpbT00AD4VUakYG4mculSeNCIJwnkzE7rpXwjNGk8MzNqC0v6Vl7czYmZvA6qQQ9cgJAhk/mVvbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K1UswQFQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso1994100a12.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Nov 2024 08:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730911768; x=1731516568; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6S1AUHW6UBpRflThxXAxbKLUbtgUucNTLl+SKy8RQpU=;
        b=K1UswQFQQXitNSkEOQm7lVDw/LxiHKnuqysWiXHqng6mRPZznY9NaCKpYx6SA3Vmdf
         VMjWtZg7DBMEsjks0UyMRoynlA/JsFHsis1mNteugUWLGR1jj+qxhRbzWghMgwBQBg7O
         4XQXypwG+KuRNhUIR9z8l98tzm5kGlcBlqAJzyWF/lNOSt+PmE6bu0dz0PjLcqygPviO
         aEUs3ThITSCisVASVGR90G6V7rg61xnfpV9qI6MRNovb4YiYDI6vT7X5MYfH1fEbxMXw
         gJWRxOsdu4JKDA7Sn3WyPXH1InI+kkkZPp715iNgB2yW7mLY6hP2ChtiMb3cccRb3V3Y
         gxkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730911768; x=1731516568;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6S1AUHW6UBpRflThxXAxbKLUbtgUucNTLl+SKy8RQpU=;
        b=CpDcaNxdN9k0DtCIeb0hLeii8yTEoIfZOzC9XMVaOTm7PNboZrRp3s7v/Rer8i/OEE
         +PdP3rJfnIemeur89RmlXNsD0ccI2rqEedYOY/w490Dx1EnZYc5ewaieVnJqAUpYDlMp
         HtlVsQ+qm0gunQoT5YgeMkyBT9dTdVIOyvuSmCGlx+l7YIVzSIFSDJ8MAKzvw7hmVIbH
         fe1UDG2KUWuPPb8uiMKdtSx0wOb8ZFKZk9wXeX1yOX6GwkRmq5shINik3zANm+0iKtgC
         G+8+PYBcNSJYh3kOYgsnG3o+DncJwT7R9wAnNNqjLRuCHcHtbB2YItOtLgI/nCgdLuKV
         ZhZQ==
X-Gm-Message-State: AOJu0Yw0g0LMB8Dgw4CwI/IDf/8lL9CrHgrZGheLTA7xvVtvfOuCCrVD
	bAZ2QamMTwQCuflCmwVOoW24Z6pkbYSk75Gg5XmbD8DzwgTCW3P2nzK4TXVCt9vRLPcmSGki5pP
	5roeQYJRwYU6uPIN7mDFaEJUysj7QkwsXRdMtmmyeMGyAO/euDZg=
X-Google-Smtp-Source: AGHT+IE9j3bBgrjKdmDnfCkgfLSm2KtizyP25tf5MyWWCZaP206UyG+YjHsS5DoNDDJEAUJxZcW9aUedaFj1NEXIvgE=
X-Received: by 2002:a17:907:60cf:b0:a9e:82d2:2fe0 with SMTP id
 a640c23a62f3a-a9ec660e513mr347583466b.9.1730911768320; Wed, 06 Nov 2024
 08:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Konstantin Belov <konstantin.belov@linaro.org>
Date: Wed, 6 Nov 2024 17:49:17 +0100
Message-ID: <CAPZ5P5jj6pjZA4e4HMvNY=SFzf7Y0cBXP1kNTqi42WN+XhT7jQ@mail.gmail.com>
Subject: Some thoughts on Linux benchmarks results & processing
To: linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello colleagues,

Following up on Tim Bird's presentation "Adding benchmarks results
support to KTAP/kselftest", I would like to share some thoughts on
kernel benchmarking and kernel performance evaluation. Tim suggested
sharing these comments with the wider kselftest community for
discussion.

The topic of performance evaluation is obviously extremely complex, so
I=E2=80=99ve organised my comments into several paragraphs, each of which
focuses on a specific aspect. This should make it easier to follow and
understand the key points, such as metrics, reference values, results
data lake, interpretation of contradictory results, system profiles,
analysis and methodology.

# Metrics
A few remarks on benchmark metrics which were called =E2=80=9Cvalues=E2=80=
=9D in the
original presentation:
- Metrics must be accompanied by standardised units. This
standardisation ensures consistency across different tests and
environments, simplifying accurate comparisons and analysis.
- Each metric should be clearly labelled with its nature or kind
(throughput, speed, latency, etc). This classification is essential
for proper interpretation of the results and prevents
misunderstandings that could lead to incorrect conclusions.
- Presentation contains "May also include allowable variance", but
variance must be included into the analysis as we deal with
statistical calculations and multiple randomised values.
- I would like to note that other statistical parameters are also
worth including into comparison, like confidence levels, sample size
and so on.

# Reference Values
The concept of "reference values" introduced in the slides could be
significantly enhanced by implementing a collaborative, transparent
system for data collection and validation. This system could operate
as follows:
- Data Collection: Any user could submit benchmark results to a
centralised and public repository. This would allow for a diverse
range of hardware configurations and use cases to be represented.
- Vendor Validation: Hardware vendors would have the opportunity to
review submitted results pertaining to their products. They could then
mark certain results as "Vendor Approved," indicating that the results
align with their own testing and expectations.
- Community Review: The broader community of users and experts could
also review and vote on submitted results. Results that receive
substantial positive feedback could be marked as "Community Approved,"
providing an additional layer of validation.
- Automated Validation: Reference values must be checked, validated
and supported by multiple sources. This can be done only in an
automatic way as those processes are time consuming and require
extreme attention to details.
- Transparency: All submitted results would need to be accompanied by
detailed information about the testing environment, hardware
specifications, and methodology used. This would ensure
reproducibility and allow others to understand the context of each
result.
- Trust Building: The combination of vendor and community approval
would help establish trust in the reference values. It would mitigate
concerns about marketing bias and provide a more reliable basis for
performance comparisons.
- Accessibility: The system would be publicly accessible, allowing
anyone to reference and utilise this data in their own testing and
analysis.

Implementation of such a system would require careful consideration of
governance and funding. A community-driven, non-profit organisation
sponsored by multiple stakeholders could be an appropriate model. This
structure would help maintain neutrality and avoid potential conflicts
of interest.

While the specifics of building and managing such a system would need
further exploration, this approach could significantly improve the
reliability and usefulness of reference values in benchmark testing.
It would foster a more collaborative and transparent environment for
performance evaluation in the Linux ecosystem as well as attract
interested vendors to submit and review results.

I=E2=80=99m not very informed about the current state of the community in t=
his
field, but I=E2=80=99m sure you know better how exactly this can be done.

# Results Data Lake
Along with reference values it=E2=80=99s important to collect results on a
regular basis as the kernel evolves so results must follow this
evolution as well. To do this cloud-based data lake is needed (a
self-hosted system will be too expensive from my point of view).

This data lake should be able to collect and process incoming data as
well as to serve reference values for users. Data processing flow
should be quite standard: Collection -> Parsing + Enhancement ->
Storage -> Analysis -> Serving.

Tim proposed to use file names for reference files, I would like to
note that such approach could fail pretty fast if system will collect
more and more data and there will rise a need to have more granular
and detailed features to identify reference results and this can lead
to very long filenames, which will be hard to use. I propose to use
UUID4-based identification, which provides very low chances for
collision. Those IDs will be keys in the database with all information
required for clear identification of relevant results and
corresponding details. Moreover this approach can be easily extended
on the database side if more data is needed.

Yes, UUID4 is not human-readable, but do we need such an option if we
have tools, which can provide a better interface?

For example, this could be something like:
---
request: results-cli search -b "Test Suite D" -v "v1.2.3" -o "Ubuntu
22.04" -t "baseline" -m "response_time>100"
response:
[
{
     "id": "550e8400-e29b-41d4-a716-446655440005",
     "benchmark": "Test Suite A",
     "version": "v1.2.3",
     "target_os": "Ubuntu 22.04",
     "metrics": {
         "cpu_usage": 70.5,
         "memory_usage": 2048,
         "response_time": 120
     },
     "tags": ["baseline", "v1.0"],
     "created_at": "2024-10-25T10:00:00Z"
},
...
]
---
or
request: results-cli search "<Domain-Specific-Language-Query>"
response: [ {}, {}, {}...]
---
or
request: results-cli get 550e8400-e29b-41d4-a716-446655440005
response:
{
     "id": "550e8400-e29b-41d4-a716-446655440005",
     "benchmark": "Test Suite A",
     "version": "v1.2.3",
     "target_os": "Ubuntu 22.04",
     "metrics": {
         "cpu_usage": 70.5,
         "memory_usage": 2048,
         "response_time": 120
     },
     "tags": ["baseline", "v1.0"],
     "created_at": "2024-10-25T10:00:00Z"
}
---
or
request: curl -X POST http://api.example.com/references/search \ -d '{
"query": "benchmark =3D \"Test Suite A\" AND (version >=3D \"v1.2\" OR tag
IN [\"baseline\", \"regression\"]) AND cpu_usage > 60" }'
...
---

Another point of use DB-based approach is the following: in case when
a user works with particular hardware and/or would like to use a
reference he/she does not need a full database with all collected
reference values, but only a small slice of it. This slice can be
downloaded from public repo or accessed via API.

# Large results dataset
If we collect a large benchmarks dataset in one place accompanied with
detailed information about target systems from which this dataset was
collected, then it will allow us to calculate precise baselines across
different compositions of parameters, making performance deviations
easier to detect. Long-term trend analysis can identify small changes
and correlate them with updates, revealing performance drift.

Another use of such a database - predictive modelling, which can
provide forecasts of expected results and setting dynamic performance
thresholds, enabling early issue detection. Anomaly detection becomes
more effective with context, distinguishing unusual deviations from
normal behaviour.

# Interpretation of contradictory results
It=E2=80=99s not clear how to deal with contradictory results to make a
decision on regression presence. For example, we have a set of 10
tests, which test more or less the same, for example disk performance.
It=E2=80=99s unclear what to do when one subset of tests show degradation a=
nd
another subset shows neutral status or improvements. Is there a
regression?

I suppose that the availability of historical data can help to deal
with such situations as historical data can show behaviour of
particular tests and allow to assign weights in decision-making
algorithms, but it=E2=80=99s just my guess.

# System Profiles
Tim's idea to reduce results to - =E2=80=9Cpass / fail=E2=80=9D and my expe=
rience with
various people trying to interpret benchmarking results led me to
think of =E2=80=9Cprofiles=E2=80=9D - a set of parameters and metrics colle=
cted from a
reference system while execution of a particular configuration of a
particular benchmark.

Profiles can be used for A/B comparison with pass/fail outcomes or
match/not match, and this approach does not hide/miss the details and
allows to capture multiple characteristics of the experiment, like
presence of outliers/errors or skewed distribution form. Interested
persons (like kernel developers or performance engineers, for example)
can dig deeper to find a reason for such mismatch and those who are
interested just in high-level results - pass/fail should be enough.

Here is how I imaging a structure of a profile:
---
profile_a:
  system packages:
   - pkg_1
   - pkg_2
   # Additional packages...

settings:
   - cmdline
   # Additional settings...

indicators:
   cpu: null
   ram: null
   loadavg: null
   # Additional indicators...

benchmark:
settings:
   param_1: null
   param_2: null
   param_x: null

metrics:
   metric_1: null
   metric_2: null
   metric_x: null
---

- System Packages, System Settings: Usually we do not pay much
attention to this, but I think it=E2=80=99s worth highlighting that base OS=
 is
an important factor, as there are distribution-specific modifications
present in the filesystem. Most commonly developers and researchers
use Ubuntu (as the most popular distro) or Debian (as a cleaner and
lightweight version of Ubuntu), but distributions apply their own
patches to the kernel and system libraries, which may impact
performance. Another kind of base OS - cloud OS images which can be
modified by cloud providers to add internal packages & services which
could potentially affect performance as well. While comparing we must
take into account this aspect to compare apples-to-apples.
- System Indicators: These are periodic statistics like CPU
utilisation, RAM consumption, and other params collected before
benchmarking, while benchmarking and after benchmarking.
- Benchmark Settings: Benchmarking systems have multiple parameters,
so it=E2=80=99s important to capture them and use them in analysis.
- Benchmark Metrics: That=E2=80=99s obviously - benchmark results. It=E2=80=
=99s not a
rare case when a benchmark test provides more than a single number.

# Analysis
Proposed rules-based analysis will work only for highly determined
environments and systems, where rules can describe all the aspects.
Rule-based systems are easier to understand and implement than other
types, but for a small set of rules. However, we deal with the live
system and it constantly evolves, so rules will deprecate extremely
fast. It's the same story as with rule-based recommended systems in
early years of machine learning.

If you want to follow a rules-based approach, it's probably worth
taking a look at https://www.clipsrules.net as this will allow to
decouple results from analysis and avoid reinventing the analysis
engine.

Declaration of those rules will be error-prone due to the nature of
their origin - they must be declared and maintained by humans. IMHO a
human-less approach and use modern ML methods instead would be more
beneficial in the long run.

# Methodology
Used methodology - another aspect which is not directly related to
Tim's slides, but it's an important topic for results processing and
interpretation, probably an idea of automated results interpretation
can force use of one or another methodology.

# Next steps
I would be glad to participate in further discussions and share
experience to improve kernel performance testing automation, analysis
and interpretation of results. If there is interest, I'm open to
collaborating on implementing some of these ideas.
--
Best regards,
Konstantin Belov

