Return-Path: <linux-kselftest+bounces-36222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6298AAF059A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 23:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515F63BAC98
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 21:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7F530206D;
	Tue,  1 Jul 2025 21:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jbbWtmaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC21C84C5
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Jul 2025 21:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405230; cv=none; b=X6oUB7wKpEDcXaewwxL9wQzaoVg/982sYlKnKpOPkW9PFhCZYsQ79wGQ37eTcq6gN4lo5e4EwR5UZrMEN35NyXsHZLrMTTVNrRwrDie3XgwXhaAoo3VA1fUB/uBN9LbwVbVSwyktV67ebWnii99FnPbGv2wEltFnW0Rn1jOwe0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405230; c=relaxed/simple;
	bh=DzHFQiPQddZhawDVWcu2zeji/HBrjV6FWP4sfK+uAb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq/nXKJPU+y+vxyjygJ+PCIdqbtg6zkwheOG6ztarVkLyGsgcgKFj3Z1E0B887imLpqxeP8nYM2Jv6wiDcHYQ179g7wQan7sl5nybJ+ccnv+woYSByXqlWvlkuPJZnK1cbxTpfro8LogZo1C1ZxZhYaWqMwDuOflpXv7fP92To0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jbbWtmaa; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fd0a91ae98so25366016d6.1
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Jul 2025 14:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751405226; x=1752010026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EAN/JX9tNQneTS1/E3rAZ4/N5hA30DPl50YRPjyH77Q=;
        b=jbbWtmaaxDd9mQN/PxhcFTzvDn7DKdLjnzIMt8F0kQ+EfdxQhZ6DgvEn4EhV0Vge1S
         /JYUFLoG5juJIOt9Y6qLizF8DpyOj4xwj7D1pjTcvTudut0NoTHhELUFOKwQ5V6TOO0/
         oZuqaQ+bRPSxHC6TROatcOlD50nAfiAiMcuJDmW5mmGHSgCmJTFMLOGsUNQE5zIijT5I
         hla+1Hj7j1wj+3ICnUa2A6lssz7Fqyrp7Ov3UKeBgRdINZPnr4LntIGjFm7y6vtUOkJx
         l1eg8TINbS5ppK8xmiRc3iDO+pIDGsI7lPmEu5GOd+5eQGzSZ2mWrB2ukX0zvFwUJKv5
         B79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751405226; x=1752010026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAN/JX9tNQneTS1/E3rAZ4/N5hA30DPl50YRPjyH77Q=;
        b=g4sw1FqsS2RdyC5lUtlES9YKiX2/khhe1U6YlrmkxVgKTZpgErv+YiqqsYHgQRzMAY
         4SQZonxWLq6/Og0bRY4LlkOu/UIeDTQjGuganV+z/LVhgJOHYrfruDay8hKbK+FSqVQG
         BGzsiUjKwgfy8rXg8/4o2x89iyEq0lluVfwY3vyDZJ18VxyMw4t89T5G6wpZHVvjEqOT
         eAATCtLm3c23s/4yGbqM94ClAOevHSKhVp2JjNjBbDb2OEYEptOHwleaxNNVWkkTSCpJ
         nocRMFbU8SyMKICTplw0OR0j+ulW6WHqYDswTcOoH7awaH5hs5jryrQCwvzKSVd2BIAA
         ks4A==
X-Forwarded-Encrypted: i=1; AJvYcCX/vGmuwX7HHHHSbHnHJc/u3/i0ehqu2gmnUPJIZ6hcRMjPk37Aisgq161GnN4cHqqgXmW0ULqTGbW0Ejk1pA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaE84tWfrzvqW7l6QLCFeiEuCATK2o4o3puEND7XmVjNcMH9e
	J2a8oojWwHVq6N/OGUwcxY6/oY1TRq6RUU0iU96MId4O2WH1s07/v4HmXde5ZmvNcojdV8Nfmhm
	DIiYa3XMQQtxpulctE/xMcCwZtPoh2ePv9BNb42s6
X-Gm-Gg: ASbGncunbd1VF7P7UUKfvBqYFYq5IHMQDr2DnyjxGe2b0bTc0qa892JmP9KHI78T158
	wodNy7+SJXcj9+r42QhBb8L78wUkt/o7x5dMDTp9zY3nWhiKwzx8pi9VljwhlHtg+GLDimk2Z4F
	74Vx7Wild5E9isK+k50d9Tu8wME3wu2ZOTugbqacLsdw6QiQIyJGOIkjTUxipwMTisFXcaOk8sT
	g==
X-Google-Smtp-Source: AGHT+IGA7WQ+e3XksnB6m51usyyvNfN+MXcxbddeJ/9KeHNUIOLXzuYXqSKDJLS8QQzczdjQx/nSEiEiD6ZJ/P7pVhw=
X-Received: by 2002:a05:6214:c22:b0:6fa:cb9b:a793 with SMTP id
 6a1803df08f44-702b1aef861mr2025266d6.26.1751405226231; Tue, 01 Jul 2025
 14:27:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626-kunit-kselftests-v4-0-48760534fef5@linutronix.de> <20250626-kunit-kselftests-v4-7-48760534fef5@linutronix.de>
In-Reply-To: <20250626-kunit-kselftests-v4-7-48760534fef5@linutronix.de>
From: Rae Moar <rmoar@google.com>
Date: Tue, 1 Jul 2025 17:26:55 -0400
X-Gm-Features: Ac12FXwG0XmNtlAv7hUPU9jHLcT8Tyd4GL9zm8DXnJELkX1C01cyvv9A2Y6Bosg
Message-ID: <CA+GJov6boJrF25-3RXJHzSUvdX49J-UtmMaLTzeV8uLB3LY8og@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] kunit: tool: Add test for nested test result reporting
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 2:10=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Currently there is no test validating the result reporting from nested
> tests. Add one, it will also be used to validate upcoming changes to the
> nested test parsing.

Hello!

This patch looks good to me! However, most of the tests in
kunit-tool-test do check nested test output but we do lack checks for
failing tests. Could we change this commit description to be something
like: "Currently there is a lack of tests validating failed results
reporting from nested tests."?

Reviewed-by: Rae Moar <rmoar@google.com>

Thanks!
-Rae

>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Reviewed-by: David Gow <davidgow@google.com>
> ---
>  tools/testing/kunit/kunit_tool_test.py                         | 10 ++++=
++++++
>  .../kunit/test_data/test_is_test_passed-failure-nested.log     |  7 ++++=
+++
>  2 files changed, 17 insertions(+)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit=
/kunit_tool_test.py
> index bbba921e0eacb18663abfcabb2bccf330d8666f5..b74dc05fc2fe5b3ff629172fc=
7aafeb5c3d29fb3 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -165,6 +165,16 @@ class KUnitParserTest(unittest.TestCase):
>                 self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
status)
>                 self.assertEqual(result.counts.errors, 0)
>
> +       def test_parse_failed_nested_tests_log(self):
> +               nested_log =3D test_data_path('test_is_test_passed-failur=
e-nested.log')
> +               with open(nested_log) as file:
> +                       result =3D kunit_parser.parse_run_tests(file.read=
lines(), stdout)
> +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
status)
> +               self.assertEqual(result.counts.failed, 2)
> +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
subtests[0].status)
> +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
subtests[1].status)
> +               self.assertEqual(kunit_parser.TestStatus.FAILURE, result.=
subtests[1].subtests[0].status)
> +
>         def test_no_header(self):
>                 empty_log =3D test_data_path('test_is_test_passed-no_test=
s_run_no_header.log')
>                 with open(empty_log) as file:
> diff --git a/tools/testing/kunit/test_data/test_is_test_passed-failure-ne=
sted.log b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested=
.log
> new file mode 100644
> index 0000000000000000000000000000000000000000..2e528da39ab5b2be0fca6cf91=
60c10929fba3c9e
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_is_test_passed-failure-nested.lo=
g
> @@ -0,0 +1,7 @@
> +KTAP version 1
> +1..2
> +not ok 1 subtest 1
> +    KTAP version 1
> +    1..1
> +        not ok 1 subsubtest 1
> +not ok 2 subtest 2
>
> --
> 2.50.0
>

