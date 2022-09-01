Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0759B5A8E58
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Sep 2022 08:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiIAGhW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Sep 2022 02:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiIAGhV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Sep 2022 02:37:21 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E05C1210
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 23:37:19 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id m66so16776540vsm.12
        for <linux-kselftest@vger.kernel.org>; Wed, 31 Aug 2022 23:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZN3L+PoTPUpuUxHFLZCvo6zCxSxPDvjoOtr8auSXbjE=;
        b=ri7KA3tItGTHqnM6pYMlVms2QC/xUYgLCNNyyLmtiYgJ0Or0jWB9LDbTmYLrHLoXYe
         rpRVPic4QxDsZwSkfHWQNGCAeWQUWyibWDp1Kn1RDU7a4deXVo7mMCILpL2q4Ri0HQei
         xAJ5bA+SIyQQ2oBJy7dm4HYMln5WQpzzU58MZH5IScFG/c9O27R19EfQotNxbaOJXaqp
         ELvbiCmxH9pT5nX7iezRgUhCMH5T9IR8QOhHZk4b4QPMxwy+7t7ASti37qbl+OeGGjVc
         kZX2wZrjvXiUHPxmSnkfa0JYrzVa4PS1bbLz2JF2/Hu9r/MoS7DRdL8O44Mycm6qMQv7
         44bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZN3L+PoTPUpuUxHFLZCvo6zCxSxPDvjoOtr8auSXbjE=;
        b=KU+57YwOZrVUWhYbtgZ9cb8NKUDOn1ZXDnKQttQFXIjgM1kmFwQOyG5BXZy0iK1RuZ
         +AycB7qdUOB2gRmx34BCuNf1fGe9c4KcUPo+X373iYmVyGrmPtZgPedGjwRlGKqTfk1r
         2VIYlwJU13wGWj3MjezxrCTcmAOfoZISWcjhlRoCywadqWdPJdbeVxazy0P7mqofwrpX
         UgHZRRSqap730LHG4bfqn1LmE+axrpZlF1ax37D0vNO3RkCKc3diyWvplL1tokpxl5kX
         I7bwrm1rkS7ihu5n/RtW0LNnOjgFNxFVoX+c4oeIJna5CcpN4LWPiSxHuQR6fYS5fFh9
         E0+Q==
X-Gm-Message-State: ACgBeo3SWIuZBNolrF6dFRvxxcPTy0A2nlLs9sDglIK1WICTwPfbNDpC
        k2Eabg0GKqreexwNreoFqhtmnva6HHsR+TeWO6YqUw==
X-Google-Smtp-Source: AA6agR4NAV19QWIHoFEXU6O+uthAhDMaD87xdUwCVjxquvOW+2ucg/oF3TA8+SwqtmHQeMF+H6kECODeanHrPnTUA0g=
X-Received: by 2002:a05:6102:38c6:b0:390:e7e4:8a7e with SMTP id
 k6-20020a05610238c600b00390e7e48a7emr5592768vst.38.1662014238449; Wed, 31 Aug
 2022 23:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220829000920.38185-1-isabbasso@riseup.net> <20220829000920.38185-4-isabbasso@riseup.net>
In-Reply-To: <20220829000920.38185-4-isabbasso@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Thu, 1 Sep 2022 14:37:06 +0800
Message-ID: <CABVgOS=HO9XAf8C5X7ZD6aTW37r06ify==7AW9a8cpKsgLVfFw@mail.gmail.com>
Subject: Re: [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility for KUnit
To:     Isabella Basso <isabbasso@riseup.net>
Cc:     igt-dev@lists.freedesktop.org, magalilemes00@gmail.com,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>, mwen@igalia.com,
        andrealmeid@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        KUnit Development <kunit-dev@googlegroups.com>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@fooishbar.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000050f3d005e797d857"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--00000000000050f3d005e797d857
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 29, 2022 at 8:10 AM Isabella Basso <isabbasso@riseup.net> wrote:
>
> This adds functions for both executing the tests as well as parsing (K)TAP
> kmsg output, as per the KTAP spec [1].
>
> [1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---

Thanks very much for sending these patches out again.

Alas, I don't have a particularly useful igt setup to test this
properly, but I've left a couple of notes from trying it on my laptop
here.


>  lib/igt_kmod.c | 290 +++++++++++++++++++++++++++++++++++++++++++++++++
>  lib/igt_kmod.h |   2 +
>  2 files changed, 292 insertions(+)
>
> diff --git a/lib/igt_kmod.c b/lib/igt_kmod.c
> index 97cac7f5..93cdfcc5 100644
> --- a/lib/igt_kmod.c
> +++ b/lib/igt_kmod.c
> @@ -25,6 +25,7 @@
>  #include <signal.h>
>  #include <errno.h>
>  #include <sys/utsname.h>
> +#include <limits.h>
>
>  #include "igt_aux.h"
>  #include "igt_core.h"
> @@ -32,6 +33,8 @@
>  #include "igt_sysfs.h"
>  #include "igt_taints.h"
>
> +#define BUF_LEN 4096
> +
>  /**
>   * SECTION:igt_kmod
>   * @short_description: Wrappers around libkmod for module loading/unloading
> @@ -713,6 +716,293 @@ void igt_kselftest_get_tests(struct kmod_module *kmod,
>         kmod_module_info_free_list(pre);
>  }
>
> +/**
> + * lookup_value:
> + * @haystack: the string to search in
> + * @needle: the string to search for
> + *
> + * Returns: the value of the needle in the haystack, or -1 if not found.
> + */
> +static long lookup_value(const char *haystack, const char *needle)
> +{
> +       const char *needle_rptr;
> +       char *needle_end;
> +       long num;
> +
> +       needle_rptr = strcasestr(haystack, needle);
> +
> +       if (needle_rptr == NULL)
> +               return -1;
> +
> +       /* skip search string and whitespaces after it */
> +       needle_rptr += strlen(needle);
> +
> +       num = strtol(needle_rptr, &needle_end, 10);
> +
> +       if (needle_rptr == needle_end)
> +               return -1;
> +
> +       if (num == LONG_MIN || num == LONG_MAX)
> +               return 0;
> +
> +       return num > 0 ? num : 0;
> +}
> +
> +static int find_next_tap_subtest(char *record, char *test_name,
> +                                bool is_subtest)
> +{
> +       const char *name_lookup_str,
> +             *lend, *version_rptr, *name_rptr;
> +       long test_count;
> +
> +       name_lookup_str = "test: ";
> +
> +       version_rptr = strcasestr(record, "TAP version ");
> +       name_rptr = strcasestr(record, name_lookup_str);
> +
> +       /*
> +        * total test count will almost always appear as 0..N at the beginning
> +        * of a run, so we use it as indication of a run
> +        */
> +       test_count = lookup_value(record, "..");
> +
> +       /* no count found, so this is probably not starting a (sub)test */
> +       if (test_count < 0) {
> +               if (name_rptr != NULL) {
> +                       if (test_name[0] == '\0')
> +                               strncpy(test_name,
> +                                       name_rptr + strlen(name_lookup_str),
> +                                       BUF_LEN);
> +                       else if (strcmp(test_name, name_rptr + strlen(name_lookup_str)) == 0)
> +                               return 0;
> +                       else
> +                               test_name[0] = '\0';
> +
> +               }
> +               return -1;
> +       }
> +
> +       /*
> +        * "(K)TAP version XX" should be the first line on all (sub)tests as per
> +        * https://www.kernel.org/doc/html/latest/dev-tools/ktap.html#version-lines
> +        * but actually isn't, as it currently depends on whoever writes the
> +        * test to print this info

FYI: we're really trying to fix cases of "missing version lines",
largely by making the kunit_test_suites() macro work in more
circumstances.

So while it may be worth still handling the case where this is
missing, I don't think there are any tests in the latest versions of
the kernel which should have this missing.

> +        */
> +       if (version_rptr == NULL)
> +               igt_info("Missing test version string\n");
> +
> +       if (name_rptr == NULL) {
> +               /* we have to keep track of the name string, as it might be
> +                * contained in a line read previously */
> +               if (test_name[0] == '\0') {
> +                       igt_info("Missing test name string\n");
> +
> +                       if (is_subtest)
> +                               igt_info("Running %ld subtests...\n", test_count);
> +                       else
> +                               igt_info("Running %ld tests...\n", test_count);
> +               } else {
> +                       lend = strchrnul(test_name, '\n');
> +
> +                       if (*lend == '\0') {
> +                               if (is_subtest)
> +                                       igt_info("Executing %ld subtests in: %s\n",
> +                                                test_count, test_name);
> +                               else
> +                                       igt_info("Executing %ld tests in: %s\n",
> +                                                test_count, test_name);
> +                               return test_count;
> +                       }
> +
> +                       if (is_subtest)
> +                               igt_info("Executing %ld subtests in: %.*s\n",
> +                                        test_count, (int)(lend - test_name),
> +                                        test_name);
> +                       else
> +                               igt_info("Executing %ld tests in: %.*s\n",
> +                                        test_count, (int)(lend - test_name),
> +                                        test_name);
> +                       test_name[0] = '\0';
> +               }
> +       } else {
> +               name_rptr += strlen(name_lookup_str);
> +               lend = strchrnul(name_rptr, '\n');
> +               /*
> +                * as the test count comes after the test name we need not check
> +                * for a long line again
> +                */
> +               if (is_subtest)
> +                       igt_info("Executing %ld subtests in: %.*s\n",
> +                                test_count, (int)(lend - name_rptr),
> +                                name_rptr);
> +               else
> +                       igt_info("Executing %ld tests in: %.*s\n",
> +                                test_count, (int)(lend - name_rptr),
> +                                name_rptr);
> +       }
> +
> +       return test_count;
> +}
> +
> +static void parse_kmsg_for_tap(const char *lstart, char *lend,
> +                              int *sublevel, bool *failed_tests)
> +{
> +       const char *nok_rptr, *comment_start, *value_parse_start;
> +
> +       nok_rptr = strstr(lstart, "not ok ");
> +       if (nok_rptr != NULL) {
> +               igt_warn("kmsg> %.*s\n",
> +                        (int)(lend - lstart), lstart);
> +               *failed_tests = true;
> +               return;
> +       }
> +
> +       comment_start = strchrnul(lstart, '#');
> +
> +       /* check if we're still in a subtest */
> +       if (*comment_start != '\0') {
> +               comment_start++;
> +               value_parse_start = comment_start;
> +
> +               if (lookup_value(value_parse_start, "fail: ") > 0) {
> +                       igt_warn("kmsg> %.*s\n",
> +                                (int)(lend - comment_start), comment_start);
> +                       *failed_tests = true;
> +                       (*sublevel)--;
> +                       return;
> +               }
> +       }
> +
> +       igt_info("kmsg> %.*s\n",
> +                (int)(lend - lstart), lstart);
> +}
> +
> +static void igt_kunit_subtests(int fd, char *record,
> +                              int *sublevel, bool *failed_tests)
> +{
> +       char test_name[BUF_LEN + 1], *lend;
> +
> +       lend = NULL;
> +       test_name[0] = '\0';
> +       test_name[BUF_LEN] = '\0';
> +
> +       while (*sublevel >= 0) {
> +               const char *lstart;
> +               ssize_t r;
> +
> +               if (lend != NULL && *lend != '\0')
> +                       lseek(fd, (int) (lend - record), SEEK_CUR);
> +
> +               r = read(fd, record, BUF_LEN);
> +
> +               if (r <= 0) {
> +                       switch (errno) {
> +                       case EINTR:
> +                               continue;
> +                       case EPIPE:
> +                               igt_warn("kmsg truncated: too many messages. \
> +                                        You may want to increase log_buf_len \
> +                                        in your boot options\n");
> +                               continue;
> +                       case !EAGAIN:
> +                               igt_warn("kmsg truncated: unknown error (%m)\n");
> +                               *sublevel = -1;
> +                       default:
> +                               break;
> +                       }
> +                       break;
> +               }
> +
> +               lend = strchrnul(record, '\n');
> +
> +               /* in case line > 4096 */
> +               if (*lend == '\0')
> +                       continue;
> +
> +               if (find_next_tap_subtest(record, test_name, *sublevel > 0) != -1)
> +                       (*sublevel)++;
> +
> +               if (*sublevel > 0) {
> +                       lstart = strchrnul(record, ';');
> +
> +                       if (*lstart == '\0') {
> +                               igt_warn("kmsg truncated: output malformed (%m)\n");
> +                               igt_fail(IGT_EXIT_FAILURE);
> +                       }
> +
> +                       lstart++;
> +                       while (isspace(*lstart))
> +                               lstart++;
> +
> +                       parse_kmsg_for_tap(lstart, lend, sublevel, failed_tests);
> +               }
> +       }
> +
> +       if (*failed_tests || *sublevel < 0)
> +               igt_fail(IGT_EXIT_FAILURE);
> +       else
> +               igt_success();
> +}
> +
> +/**
> + * igt_kunit:
> + * @module_name: the name of the module
> + * @opts: options to load the module
> + *
> + * Loads the kunit module, parses its dmesg output, then unloads it
> + */
> +void igt_kunit(const char *module_name, const char *opts)
> +{
> +       struct igt_ktest tst;
> +       char record[BUF_LEN + 1];
> +       bool failed_tests = false;
> +       int sublevel = 0;
> +
> +       record[BUF_LEN] = '\0';
> +
> +       /* get normalized module name */
> +       if (igt_ktest_init(&tst, module_name) != 0) {
> +               igt_warn("Unable to initialize ktest for %s\n", module_name);
> +               return;
> +       }
> +
> +       if (igt_ktest_begin(&tst) != 0) {
> +               igt_warn("Unable to begin ktest for %s\n", module_name);
> +
> +               igt_ktest_fini(&tst);
> +               return;
> +       }
> +
> +       if (tst.kmsg < 0) {
> +               igt_warn("Could not open /dev/kmsg");
> +               goto unload;
> +       }
> +
> +       if (lseek(tst.kmsg, 0, SEEK_END)) {
> +               igt_warn("Could not seek the end of /dev/kmsg");
> +               goto unload;
> +       }
> +
> +       /* The kunit module is required for running any kunit tests */
> +       if (igt_kmod_load("kunit", NULL) != 0) {
> +               igt_warn("Unable to load kunit module\n");
> +               goto unload;
> +       }

Do you want to _require_ KUnit be built as a module, rather than built-in here?

Equally, does this need to mark a failure (or at least "SKIPPED")
rather than success, in the case it fails.

> +
> +       if (igt_kmod_load(module_name, opts) != 0) {
> +               igt_warn("Unable to load %s module\n", module_name);
> +               goto unload;
> +       }

As above, should this record a failure, or skip?

> +
> +       igt_kunit_subtests(tst.kmsg, record, &sublevel, &failed_tests);
> +unload:
> +       igt_kmod_unload("kunit", 0);

Do you want to unconditionally unload the KUnit module here? It's safe
(maybe even safer) to leave it loaded between runs of KUnit tests.

Equally, how would you handle the case where KUnit is already loaded?

> +
> +       igt_ktest_end(&tst);
> +
> +       igt_ktest_fini(&tst);
> +}
> +
>  static int open_parameters(const char *module_name)
>  {
>         char path[256];
> diff --git a/lib/igt_kmod.h b/lib/igt_kmod.h
> index ceb10cd0..737143c1 100644
> --- a/lib/igt_kmod.h
> +++ b/lib/igt_kmod.h
> @@ -45,6 +45,8 @@ int __igt_i915_driver_unload(char **whom);
>  int igt_amdgpu_driver_load(const char *opts);
>  int igt_amdgpu_driver_unload(void);
>
> +void igt_kunit(const char *module_name, const char *opts);
> +
>  void igt_kselftests(const char *module_name,
>                     const char *module_options,
>                     const char *result_option,
> --
> 2.37.2
>

Regardless, thanks very much. Hopefully I'll get a chance to play with
igt a bit more and actually get the tests running. :-)

Cheers,
-- David

--00000000000050f3d005e797d857
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAT
RyBcXrTOEAP2f/+NfBlL7nTa06Tef6ZoLoWBtIKhmjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA5MDEwNjM3MThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEASpjSj1HUnHQR5Q76k7l/
eUA9Kjgtkr3Ue3Qe7Z1uKMQV0MMJLfFAOBT1SwMNgut+v9LwVO/O68gFhlAFy3SmF1DFVin1hZl9
PNuTS+6AYwyegqGXuJWqaMcYAOn2Uo8ewoYvru73SbAULuSEBQpMqzHYTsZa47RwFcWNfaPf25ZI
I04ld4dvq88MDm/j4dl9oajFGI7kuEYJmCP7z7rnzDDzhf4sm2YqnqgoMW0W0ghecRmzwNnS+O/X
Dmm7vvlPufd7LFa8k8NCMm48Nb0PfFmZCC34N4PZ2HdZ7OuFfZPbCxhIM2UF6ElhYEAmn7tTaiI8
pm+e2VZ18ul6Ac5hzg==
--00000000000050f3d005e797d857--
