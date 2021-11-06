Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F989446C4A
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Nov 2021 05:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhKFEJq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 6 Nov 2021 00:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhKFEJq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 6 Nov 2021 00:09:46 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAE8C061714
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 21:07:05 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v127so8631059wme.5
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 21:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dAMkQtG88zF4lTfMnqIkOw1xJVTeo1G4ICraZh1KtNM=;
        b=lLfn15aR0lGErOtXk3C7TyHNDDxY/VQv7WN+XdhOqB+nsTEkYD9zfnW16QuBnzo4FP
         2CbiY4nYqv/5izFqp1bMJx+lPHCWSoTyUS1OXpCDyBB9cYKRuZGllDAX9kSbqi4p5IKR
         jxfUJaDoaM+Euk0+dN52ONIg/6DVE3peRfjIEsElvRCHa0eIuNclCeo1C9IxIq/nOKtx
         1RX2NFuz2Yb86Uj9oC/uXW7ocuUw3gKgcyOrN6R6fHg5+XPV5piF3VmA6ApqN+WcLdK8
         rcklFrAeizifl6HnpZr9YXD8o2bwYQMaWlKez8pT+UOeTOt8wVbffwyt1zcjiJ0vKKZY
         8hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dAMkQtG88zF4lTfMnqIkOw1xJVTeo1G4ICraZh1KtNM=;
        b=I1OiUkNK+V8LBHY/39FRFEQ2IQMjI19LSxD2Nv2pE7bLEHya+5SI+Ryucy54vpOmpG
         6OzT6gvgkKlGGb7kunKD6BJTjyR/24fX1ht83y2Jp/DlHPZw8dNyeM2UQRI6NCQhYRur
         w4NkEDxL0pMDFP4aUMk2nL8REyczOhG65S7RC8Cwg8K4qDCZAMRiQRwf5IlKakHH5T0v
         /FHmZMfeN83jOjczRYfTgFkbFRpeymui94TVVUDQQTh9RHgkkMRHkMHvScsmnDqHh2Qa
         kA/5K6sMq2HPEws1kDki8Ho8S3Qlyyevt0FvBrGhLu5dBhIc83iW9Hem1PXGF0pIkkii
         1HhA==
X-Gm-Message-State: AOAM532uK/oyg6fk/ZALvBEbg5Y0GBkJTR3p+Gs2ruVQbjAkaQRp3vkJ
        kXjGkXDWS/uqOaq1ZFazDCm98WJUiDMUuYBIyvOdPg==
X-Google-Smtp-Source: ABdhPJz78LnSLShmeH9BkeqeAzwrRFWtrvfQfoaC5OZdFFFh9Vr1X2Zo+zchsRf/UXh9XU4LaZD1gMfDmnVZEcvQM3c=
X-Received: by 2002:a7b:cc1a:: with SMTP id f26mr35274375wmh.39.1636171623744;
 Fri, 05 Nov 2021 21:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211106013058.2621799-1-dlatypov@google.com>
In-Reply-To: <20211106013058.2621799-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 6 Nov 2021 12:06:52 +0800
Message-ID: <CABVgOSnKdo1U6QFvQ3XiMoWmony93auzYyaMXs9f7UXa3GpGgg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: move Kconfig read_from_file/parse_from_string
 to package-level
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 6, 2021 at 9:31 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> read_from_file() clears its `self` Kconfig object and parses a config
> file.
>
> It is a way to construct Kconfig objects more so than an operation on
> Kconfig objects. This is reflected in the fact its only ever used as:
>   kconfig = kunit_config.Kconfig()
>   kconfig.read_from_file(path)
>
> So clean this up and simplify callers by replacing it with
>   kconfig = kunit_config.parse_file(path)
>
> Do the same thing for the related parse_from_string() function as well.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks sensible, works fine.

Reviewed-by: David Gow <davidgow@google.com>

Thanks,
-- David


>  tools/testing/kunit/kunit_config.py    | 61 +++++++++++++-------------
>  tools/testing/kunit/kunit_kernel.py    | 12 ++---
>  tools/testing/kunit/kunit_tool_test.py |  6 +--
>  3 files changed, 37 insertions(+), 42 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
> index c77c7d2ef622..677354546156 100644
> --- a/tools/testing/kunit/kunit_config.py
> +++ b/tools/testing/kunit/kunit_config.py
> @@ -62,33 +62,34 @@ class Kconfig(object):
>                         for entry in self.entries():
>                                 f.write(str(entry) + '\n')
>
> -       def parse_from_string(self, blob: str) -> None:
> -               """Parses a string containing KconfigEntrys and populates this Kconfig."""
> -               self._entries = []
> -               is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
> -               config_matcher = re.compile(CONFIG_PATTERN)
> -               for line in blob.split('\n'):
> -                       line = line.strip()
> -                       if not line:
> -                               continue
> -
> -                       match = config_matcher.match(line)
> -                       if match:
> -                               entry = KconfigEntry(match.group(1), match.group(2))
> -                               self.add_entry(entry)
> -                               continue
> -
> -                       empty_match = is_not_set_matcher.match(line)
> -                       if empty_match:
> -                               entry = KconfigEntry(empty_match.group(1), 'n')
> -                               self.add_entry(entry)
> -                               continue
> -
> -                       if line[0] == '#':
> -                               continue
> -                       else:
> -                               raise KconfigParseError('Failed to parse: ' + line)
> -
> -       def read_from_file(self, path: str) -> None:
> -               with open(path, 'r') as f:
> -                       self.parse_from_string(f.read())
> +def parse_file(path: str) -> Kconfig:
> +       with open(path, 'r') as f:
> +               return parse_from_string(f.read())
> +
> +def parse_from_string(blob: str) -> Kconfig:
> +       """Parses a string containing Kconfig entries."""
> +       kconfig = Kconfig()
> +       is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
> +       config_matcher = re.compile(CONFIG_PATTERN)
> +       for line in blob.split('\n'):
> +               line = line.strip()
> +               if not line:
> +                       continue
> +
> +               match = config_matcher.match(line)
> +               if match:
> +                       entry = KconfigEntry(match.group(1), match.group(2))
> +                       kconfig.add_entry(entry)
> +                       continue
> +
> +               empty_match = is_not_set_matcher.match(line)
> +               if empty_match:
> +                       entry = KconfigEntry(empty_match.group(1), 'n')
> +                       kconfig.add_entry(entry)
> +                       continue
> +
> +               if line[0] == '#':
> +                       continue
> +               else:
> +                       raise KconfigParseError('Failed to parse: ' + line)
> +       return kconfig
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index 66095568bf32..51ee6e5dae91 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -116,8 +116,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
>                 self._extra_qemu_params = qemu_arch_params.extra_qemu_params
>
>         def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
> -               kconfig = kunit_config.Kconfig()
> -               kconfig.parse_from_string(self._kconfig)
> +               kconfig = kunit_config.parse_from_string(self._kconfig)
>                 base_kunitconfig.merge_in_entries(kconfig)
>
>         def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
> @@ -249,8 +248,7 @@ class LinuxSourceTree(object):
>                         if not os.path.exists(kunitconfig_path):
>                                 shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
>
> -               self._kconfig = kunit_config.Kconfig()
> -               self._kconfig.read_from_file(kunitconfig_path)
> +               self._kconfig = kunit_config.parse_file(kunitconfig_path)
>
>         def clean(self) -> bool:
>                 try:
> @@ -262,8 +260,7 @@ class LinuxSourceTree(object):
>
>         def validate_config(self, build_dir) -> bool:
>                 kconfig_path = get_kconfig_path(build_dir)
> -               validated_kconfig = kunit_config.Kconfig()
> -               validated_kconfig.read_from_file(kconfig_path)
> +               validated_kconfig = kunit_config.parse_file(kconfig_path)
>                 if not self._kconfig.is_subset_of(validated_kconfig):
>                         invalid = self._kconfig.entries() - validated_kconfig.entries()
>                         message = 'Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, ' \
> @@ -291,8 +288,7 @@ class LinuxSourceTree(object):
>                 """Creates a new .config if it is not a subset of the .kunitconfig."""
>                 kconfig_path = get_kconfig_path(build_dir)
>                 if os.path.exists(kconfig_path):
> -                       existing_kconfig = kunit_config.Kconfig()
> -                       existing_kconfig.read_from_file(kconfig_path)
> +                       existing_kconfig = kunit_config.parse_file(kconfig_path)
>                         self._ops.make_arch_qemuconfig(self._kconfig)
>                         if not self._kconfig.is_subset_of(existing_kconfig):
>                                 print('Regenerating .config ...')
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 9c4126731457..4ec70e41ec5a 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -50,10 +50,9 @@ class KconfigTest(unittest.TestCase):
>                 self.assertFalse(kconfig1.is_subset_of(kconfig0))
>
>         def test_read_from_file(self):
> -               kconfig = kunit_config.Kconfig()
>                 kconfig_path = test_data_path('test_read_from_file.kconfig')
>
> -               kconfig.read_from_file(kconfig_path)
> +               kconfig = kunit_config.parse_file(kconfig_path)
>
>                 expected_kconfig = kunit_config.Kconfig()
>                 expected_kconfig.add_entry(
> @@ -86,8 +85,7 @@ class KconfigTest(unittest.TestCase):
>
>                 expected_kconfig.write_to_file(kconfig_path)
>
> -               actual_kconfig = kunit_config.Kconfig()
> -               actual_kconfig.read_from_file(kconfig_path)
> +               actual_kconfig = kunit_config.parse_file(kconfig_path)
>
>                 self.assertEqual(actual_kconfig.entries(),
>                                  expected_kconfig.entries())
>
> base-commit: 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a
> --
> 2.34.0.rc0.344.g81b53c2807-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20211106013058.2621799-1-dlatypov%40google.com.
