Return-Path: <linux-kselftest+bounces-1408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E40809A16
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 04:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BF101C20992
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Dec 2023 03:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472C820F4;
	Fri,  8 Dec 2023 03:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbXD9aty"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ED010CA
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Dec 2023 19:13:16 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso3446a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Dec 2023 19:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702005195; x=1702609995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HNS+ovI/q3JlBtEM2uaw1KWaKlXeGtEnkG9NS8Et7tA=;
        b=gbXD9atyXPm1oP5XU2qeen+pJTOmZ3e7iuZfb3wcN5G4mm0Aag6J77DYgA2Cm/RYz3
         VnyWsQLRRsJ25zx4+j944KrbGoQTYS5wcATkdB7i2YPSLtNz7949WzZjb+UOH/bxuCyk
         49Xy4ScmeS2wecVCQ5dxBNxglrovY7RKTfjWETzfq+E82GvCtt9bEWUb/GX9aXiVtLy1
         vQO+AY6le5lApFq2Mu/fiVNEVpP6HXiQh35qVKDno5R5dN7LZRaQx3wz4xB/4OFFrs7S
         1oHgf/M3gVEWrGhTyiqEcL0WBMU2iWngKfsFAEHQUVRdL4lWVZJ1EjrxfbTqgyo2JFR2
         b9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702005195; x=1702609995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HNS+ovI/q3JlBtEM2uaw1KWaKlXeGtEnkG9NS8Et7tA=;
        b=Vi1DDrDVg20LsWN16TyF//ledfmIXXiYxKTYL81XTNYV+jrhpiJ8H0Y63+EVkxs6D/
         j4MBOfmRcRSzjUYzS4TKHFi9iv9IB8eRVaOsaLiutAjw3KYQq/F7kjeXfJs7YZbJcDps
         KTw6rXed1aHqPk4FdfE14XsuO0u74lSixtognVWEH457rUqqRlrGQtQev6XfrqNlR6d0
         hJ5aSAeP9xC+NBN4yPud7uZjjqvOBYvswpnhS03OylO2e1qGJT7Y0cDS+nEAC2Dpu2Bs
         2LBWtz5hy9M1ZTzKSdASG0kqAF6uKs73fwByF/BpU9NU+Uc5ZfnqWyz3ObamJsyiXQ1I
         pD6Q==
X-Gm-Message-State: AOJu0YwUhJM/PceBF4BkQsjYuZ9rEY862klsKsibLboFwjlKXXT8kWOt
	YJAJZmJD1MAGBwbKtvNqWwpxi9jphsxDUstYsS1b/Q==
X-Google-Smtp-Source: AGHT+IF6lnS9jdG7Mel03q85kJn6B8enFm7q6yqnXLrTB095MG3Pt7OgvO20urLr5o46zc0NbKZAl1GRCClQ4zRkKn4=
X-Received: by 2002:a50:d7c3:0:b0:54a:ee8b:7a99 with SMTP id
 m3-20020a50d7c3000000b0054aee8b7a99mr20514edj.0.1702005194949; Thu, 07 Dec
 2023 19:13:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207213410.417564-1-rmoar@google.com> <20231207213410.417564-2-rmoar@google.com>
In-Reply-To: <20231207213410.417564-2-rmoar@google.com>
From: David Gow <davidgow@google.com>
Date: Fri, 8 Dec 2023 11:13:03 +0800
Message-ID: <CABVgOSkqH0Gsw-w5Dkm2dRfFTOd5_zhBawn0Lwgf+rkckRWpfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kunit: tool: add test for parsing attributes
To: Rae Moar <rmoar@google.com>
Cc: shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Dec 2023 at 05:34, Rae Moar <rmoar@google.com> wrote:
>
> Add test for parsing attributes to kunit_tool_test.py. Test checks
> attributes are parsed and saved in the test logs.
>
> This test also checks that the attributes have not interfered with the
> parsing of other test information, specifically the suite header as
> the test plan was being incorrectely parsed.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> ---

Thanks -- it's good to have this tested. I'm looking forward to our
actually parsing attributes out and using them for things in the
future, too.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit_tool_test.py           | 16 ++++++++++++++++
>  .../kunit/test_data/test_parse_attributes.log    |  9 +++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 tools/testing/kunit/test_data/test_parse_attributes.log
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index b28c1510be2e..2beb7327e53f 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -331,6 +331,22 @@ class KUnitParserTest(unittest.TestCase):
>                         kunit_parser.parse_run_tests(file.readlines())
>                 self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
>
> +       def test_parse_attributes(self):
> +               ktap_log = test_data_path('test_parse_attributes.log')
> +               with open(ktap_log) as file:
> +                       result = kunit_parser.parse_run_tests(file.readlines())
> +
> +               # Test should pass with no errors
> +               self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=0))
> +               self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
> +
> +               # Ensure suite header is parsed correctly
> +               self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
> +
> +               # Ensure attributes in correct test log
> +               self.assertContains('# module: example', result.subtests[0].log)
> +               self.assertContains('# test.speed: slow', result.subtests[0].subtests[0].log)
> +
>         def test_show_test_output_on_failure(self):
>                 output = """
>                 KTAP version 1
> diff --git a/tools/testing/kunit/test_data/test_parse_attributes.log b/tools/testing/kunit/test_data/test_parse_attributes.log
> new file mode 100644
> index 000000000000..1a13c371fe9d
> --- /dev/null
> +++ b/tools/testing/kunit/test_data/test_parse_attributes.log
> @@ -0,0 +1,9 @@
> +KTAP version 1
> +1..1
> +  KTAP version 1
> +  # Subtest: suite
> +  # module: example
> +  1..1
> +  # test.speed: slow
> +  ok 1 test
> +ok 1 suite
> \ No newline at end of file

Why doesn't this have a newline at the end of the file?

I'm actually okay with it here (it's good to test the case where there
isn't one _somewhere_), but in general, I think we'd want to prefer
KTAP documents end with the trailing newline, like most text file.

