Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06AD67AA99
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 07:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjAYG5H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 01:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjAYG5H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 01:57:07 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97E4460BD
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 22:57:05 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id v81so8760776vkv.5
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 22:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i4WRkX67OFC+Y2/SyB89xJNBgzCQCpicp3GBXnKp7Jg=;
        b=WGNVmBdp5fM2nJ5ST+q8tHAKx5I6ULs5lp9GnexJZH2S1M1S9sGWDl/dIEhXmxYeyP
         T5uhmdHeAK3k9Duux0ElPd8UUtaff/tqIYQGnPcAzb1puD4Z2xtTgiAUGMfR1PBjzoV+
         /1Qs5uAU0B8pLbu4QqeTYLp2YDf2rUxVBud6McnPJ++MncNz9yp3wK112YG/RFTYahtD
         08DmdWSxE9fZYKlX2mgKKWSIS+05nKN8ovs/12B0NnvmFYzejf3uf3kJqDTc54nLcvir
         eVhYOjMJO0jg/wRe3b+rnNDZgNsX6igx8/bSH2tlf8KDGUowCOfpvxPtE63Lvo0LQlsO
         +18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i4WRkX67OFC+Y2/SyB89xJNBgzCQCpicp3GBXnKp7Jg=;
        b=2tiVH/2PLADfjYhvtvsMg3cuJTUW/WLnDREMu98hNUqRQCBQx5b/5yTtGvupgkcp1C
         /HqKiV2H9wS7M64423rZuk4PK6cCEL2wiq/Fz1VWsvEHFagvnI5ilyIHieQwTGinAlqt
         GPTtmd/8chQfNK/I4iQ2W1ZfR7ip9OWgK4mGkByLaoHQ76qJz7jzuHrcCTwpOoCWdm7V
         pzZr5s4fSMbRCN7Ys0573is30GMTNRt/rqaKASFflkKe5INyjBRYmXejgZq2MSmDc6ih
         uMMC6gIXwH3BMU6ZzYuJuxV2zJQxxcAx+QHdvTyr4+d6zbkwMMP9rcPrHiqo5+Dsl+Tp
         MFwQ==
X-Gm-Message-State: AFqh2ko53e6OJuIHWQ+jci2X/gqaaLQWrXswv21ZcoUs5CK/T3A6l2zC
        o4t4DsYFSmwbZuRSJXmzQELnZknIP6mg3sqFgTKp2w==
X-Google-Smtp-Source: AMrXdXs24MjZtPX91L1NJnOwH4N6rV9jjq9jDj+sUmw0dT2KZuLU/1G1tfhqA1bjuUr1O4ROE6oHodn8kHwl8r/vGF0=
X-Received: by 2002:a1f:1e04:0:b0:3e1:54d0:8817 with SMTP id
 e4-20020a1f1e04000000b003e154d08817mr3792032vke.37.1674629824782; Tue, 24 Jan
 2023 22:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20230121212717.10187-1-apantykhin@gmail.com>
In-Reply-To: <20230121212717.10187-1-apantykhin@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 25 Jan 2023 14:56:53 +0800
Message-ID: <CABVgOSms6xJXXuYreaFcQdE8jjcFj5Sip9gWosgRXDYkzNuuKA@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/kunit/kunit.py extract handlers
To:     Alexander Pantyukhin <apantykhin@gmail.com>
Cc:     dlatypov@google.com, brendan.higgins@linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000db2a3005f311239f"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--000000000000db2a3005f311239f
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Jan 2023 at 05:27, Alexander Pantyukhin <apantykhin@gmail.com> wrote:
>
> The main function contains a wide if-elif block that handles different
> subcommands. It's possible to make code refactoring to extract
> subcommands handlers.
>
> Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
> ---

Thanks -- this is a much nicer way of doing things!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/kunit.py | 167 ++++++++++++++++++++---------------
>  1 file changed, 96 insertions(+), 71 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 43fbe96318fe..8cd818867504 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -395,6 +395,95 @@ def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree
>                         extra_qemu_args=qemu_args)
>
>
> +def run_handler(cli_args):
> +       if not os.path.exists(cli_args.build_dir):
> +               os.mkdir(cli_args.build_dir)
> +
> +       linux = tree_from_args(cli_args)
> +       request = KunitRequest(build_dir=cli_args.build_dir,
> +                                       make_options=cli_args.make_options,
> +                                       jobs=cli_args.jobs,
> +                                       raw_output=cli_args.raw_output,
> +                                       json=cli_args.json,
> +                                       timeout=cli_args.timeout,
> +                                       filter_glob=cli_args.filter_glob,
> +                                       kernel_args=cli_args.kernel_args,
> +                                       run_isolated=cli_args.run_isolated)
> +       result = run_tests(linux, request)
> +       if result.status != KunitStatus.SUCCESS:
> +               sys.exit(1)
> +
> +
> +def config_handler(cli_args):
> +       if cli_args.build_dir and (
> +                       not os.path.exists(cli_args.build_dir)):
> +               os.mkdir(cli_args.build_dir)
> +
> +       linux = tree_from_args(cli_args)
> +       request = KunitConfigRequest(build_dir=cli_args.build_dir,
> +                                               make_options=cli_args.make_options)
> +       result = config_tests(linux, request)
> +       stdout.print_with_timestamp((
> +               'Elapsed time: %.3fs\n') % (
> +                       result.elapsed_time))
> +       if result.status != KunitStatus.SUCCESS:
> +               sys.exit(1)
> +
> +
> +def build_handler(cli_args):
> +       linux = tree_from_args(cli_args)
> +       request = KunitBuildRequest(build_dir=cli_args.build_dir,
> +                                       make_options=cli_args.make_options,
> +                                       jobs=cli_args.jobs)
> +       result = config_and_build_tests(linux, request)
> +       stdout.print_with_timestamp((
> +               'Elapsed time: %.3fs\n') % (
> +                       result.elapsed_time))
> +       if result.status != KunitStatus.SUCCESS:
> +               sys.exit(1)
> +
> +
> +def exec_handler(cli_args):
> +       linux = tree_from_args(cli_args)
> +       exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
> +                                       build_dir=cli_args.build_dir,
> +                                       json=cli_args.json,
> +                                       timeout=cli_args.timeout,
> +                                       filter_glob=cli_args.filter_glob,
> +                                       kernel_args=cli_args.kernel_args,
> +                                       run_isolated=cli_args.run_isolated)
> +       result = exec_tests(linux, exec_request)
> +       stdout.print_with_timestamp((
> +               'Elapsed time: %.3fs\n') % (result.elapsed_time))
> +       if result.status != KunitStatus.SUCCESS:
> +               sys.exit(1)
> +
> +
> +def parse_handler(cli_args):
> +       if cli_args.file is None:
> +               sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
> +               kunit_output = sys.stdin
> +       else:
> +               with open(cli_args.file, 'r', errors='backslashreplace') as f:
> +                       kunit_output = f.read().splitlines()
> +       # We know nothing about how the result was created!
> +       metadata = kunit_json.Metadata()
> +       request = KunitParseRequest(raw_output=cli_args.raw_output,
> +                                       json=cli_args.json)
> +       result, _ = parse_tests(request, metadata, kunit_output)
> +       if result.status != KunitStatus.SUCCESS:
> +               sys.exit(1)
> +
> +
> +subcommand_handlers_map = {
> +       'run': run_handler,
> +       'config': config_handler,
> +       'build': build_handler,
> +       'exec': exec_handler,
> +       'parse': parse_handler
> +}
> +
> +
>  def main(argv):
>         parser = argparse.ArgumentParser(
>                         description='Helps writing and running KUnit tests.')
> @@ -438,78 +527,14 @@ def main(argv):
>         if get_kernel_root_path():
>                 os.chdir(get_kernel_root_path())
>
> -       if cli_args.subcommand == 'run':
> -               if not os.path.exists(cli_args.build_dir):
> -                       os.mkdir(cli_args.build_dir)
> -
> -               linux = tree_from_args(cli_args)
> -               request = KunitRequest(build_dir=cli_args.build_dir,
> -                                      make_options=cli_args.make_options,
> -                                      jobs=cli_args.jobs,
> -                                      raw_output=cli_args.raw_output,
> -                                      json=cli_args.json,
> -                                      timeout=cli_args.timeout,
> -                                      filter_glob=cli_args.filter_glob,
> -                                      kernel_args=cli_args.kernel_args,
> -                                      run_isolated=cli_args.run_isolated)
> -               result = run_tests(linux, request)
> -               if result.status != KunitStatus.SUCCESS:
> -                       sys.exit(1)
> -       elif cli_args.subcommand == 'config':
> -               if cli_args.build_dir and (
> -                               not os.path.exists(cli_args.build_dir)):
> -                       os.mkdir(cli_args.build_dir)
> -
> -               linux = tree_from_args(cli_args)
> -               request = KunitConfigRequest(build_dir=cli_args.build_dir,
> -                                            make_options=cli_args.make_options)
> -               result = config_tests(linux, request)
> -               stdout.print_with_timestamp((
> -                       'Elapsed time: %.3fs\n') % (
> -                               result.elapsed_time))
> -               if result.status != KunitStatus.SUCCESS:
> -                       sys.exit(1)
> -       elif cli_args.subcommand == 'build':
> -               linux = tree_from_args(cli_args)
> -               request = KunitBuildRequest(build_dir=cli_args.build_dir,
> -                                           make_options=cli_args.make_options,
> -                                           jobs=cli_args.jobs)
> -               result = config_and_build_tests(linux, request)
> -               stdout.print_with_timestamp((
> -                       'Elapsed time: %.3fs\n') % (
> -                               result.elapsed_time))
> -               if result.status != KunitStatus.SUCCESS:
> -                       sys.exit(1)
> -       elif cli_args.subcommand == 'exec':
> -               linux = tree_from_args(cli_args)
> -               exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
> -                                               build_dir=cli_args.build_dir,
> -                                               json=cli_args.json,
> -                                               timeout=cli_args.timeout,
> -                                               filter_glob=cli_args.filter_glob,
> -                                               kernel_args=cli_args.kernel_args,
> -                                               run_isolated=cli_args.run_isolated)
> -               result = exec_tests(linux, exec_request)
> -               stdout.print_with_timestamp((
> -                       'Elapsed time: %.3fs\n') % (result.elapsed_time))
> -               if result.status != KunitStatus.SUCCESS:
> -                       sys.exit(1)
> -       elif cli_args.subcommand == 'parse':
> -               if cli_args.file is None:
> -                       sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
> -                       kunit_output = sys.stdin
> -               else:
> -                       with open(cli_args.file, 'r', errors='backslashreplace') as f:
> -                               kunit_output = f.read().splitlines()
> -               # We know nothing about how the result was created!
> -               metadata = kunit_json.Metadata()
> -               request = KunitParseRequest(raw_output=cli_args.raw_output,
> -                                           json=cli_args.json)
> -               result, _ = parse_tests(request, metadata, kunit_output)
> -               if result.status != KunitStatus.SUCCESS:
> -                       sys.exit(1)
> -       else:
> +       subcomand_handler = subcommand_handlers_map.get(cli_args.subcommand, None)
> +
> +       if subcomand_handler is None:
>                 parser.print_help()
> +               return
> +
> +       subcomand_handler(cli_args)
> +
>
>  if __name__ == '__main__':
>         main(sys.argv[1:])
> --
> 2.25.1
>

--000000000000db2a3005f311239f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
N0A3bgltvER3q1cGraQJMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAxS21FdvRtCQVc
jgEj+xxSnUr0N9reJlI5J9zRiBCWGxm5yhz965IDka3XVFEbj+beJj/gyHoxbaTGf2AjOufpcMqy
p4mtqc2l4Csudl8QeiBaOUDx4VKADbgxqpjvwD5zRpSKVj4S9y3BJi9xrRdPOm1Z2ZZYxRUxUz7d
2MXoxQsFucGJO5a4CwDBaGgJAqvwCXU5Q64rKVIUBk6mtcd3cDwX+PXqx4QrhHFGq6b6oi37YQ8B
+bhlXqlkLrbPlPFk+4Rh4EaW92iD5g8kvtXCOwvIIvs+15Io0dbpIe2W5UKo2OcyDDFvrOACmUOE
/GuEkhENcyDVyEs/4/N2u9WYMYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABj4peqtakTCOMXLZ2mEqRMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAl
vcFdY0UlfK8uOZ9RKFgGgVpgQmGbYLIKb3QYDsIhODAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMzAxMjUwNjU3MDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAyfBfMEaJai21Cm7tXwon
OtuSj70+yIICR67C2+Ktwd86GTGCyPSNBkcIwO/MIDoe+qePjRBcbDjdH4rfz+JhU1HOu2580nd7
ioyEp2eMyAACWdv9Hzec4IQvYycO/XoTQnWhhAN4ud/Z70ov1XrRqolZryphXVepKalHrKpJZ0bH
8Yy64BOZoF1RajuHzfYppZQ0dEht9ATz+9D2fgdLF58QFpcnJ2Je+GHyyYolap8oQ0yIRg1P2Uwt
LeWtbP4jpbVNfYauVV9gWjWALjEwvQiV+QzMpF7L2Nkti0Vt2ZoTBQ7LepVbBehcKReaOABdByoM
4amT2cIuOxwXL1XERQ==
--000000000000db2a3005f311239f--
