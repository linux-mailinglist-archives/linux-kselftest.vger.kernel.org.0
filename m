Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7575BD5CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 22:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiISUng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 16:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiISUnd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 16:43:33 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D559C4A81E;
        Mon, 19 Sep 2022 13:43:31 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MWc8M2d8qzDqQx;
        Mon, 19 Sep 2022 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1663620211; bh=moP01r7W2CTQ+bvdQLlQMHQhiuiCi4RIylpN/PDDHXM=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=OavO9UljfoqQMuph/JKLxgSCLMFRb4JfEwu1tHdXWGvZyEgx+t2j7cUuGXbYEG2Yb
         x1OOVfBQpXlmwP6j73sfkcdK3qiKBPzmRcbr3CBjzkgtDKxb6lP9LOTsfzJ8qamXSR
         eH/fXg1/tWmhxIYndT5d9+0glHjQLdQjdvru3Jj0=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MWc8K61z5z9s8h;
        Mon, 19 Sep 2022 20:43:29 +0000 (UTC)
X-Riseup-User-ID: 9B18A1EBE9B10BAB879071F7D5E57B7DABD350312A8BBE900DA00F59CBB39DFE
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MWc8B3bqnz5vRK;
        Mon, 19 Sep 2022 20:43:22 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility for KUnit
From:   Isabella Basso <isabbasso@riseup.net>
In-Reply-To: <CABVgOS=HO9XAf8C5X7ZD6aTW37r06ify==7AW9a8cpKsgLVfFw@mail.gmail.com>
Date:   Mon, 19 Sep 2022 17:43:19 -0300
Cc:     igt-dev@lists.freedesktop.org,
        Magali Lemes <magalilemes00@gmail.com>,
        =?utf-8?Q?Ma=C3=ADra_Canal?= <maira.canal@usp.br>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        Trevor Woerner <twoerner@gmail.com>,
        leandro.ribeiro@collabora.com, n@nfraprado.net,
        KUnit Development <kunit-dev@googlegroups.com>,
        Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        daniel@fooishbar.org, kernel list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D53B4EB1-1A95-48F1-BF49-8EC0CC7B5418@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
 <20220829000920.38185-4-isabbasso@riseup.net>
 <CABVgOS=HO9XAf8C5X7ZD6aTW37r06ify==7AW9a8cpKsgLVfFw@mail.gmail.com>
To:     David Gow <davidgow@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, David

> Am 01/09/2022 um 3:37 AM schrieb 'David Gow' via KUnit Development =
<kunit-dev@googlegroups.com>:
>=20
> On Mon, Aug 29, 2022 at 8:10 AM Isabella Basso <isabbasso@riseup.net> =
wrote:
>>=20
>> This adds functions for both executing the tests as well as parsing =
(K)TAP
>> kmsg output, as per the KTAP spec [1].
>>=20
>> [1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
>>=20
>> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
>> ---
>=20
> Thanks very much for sending these patches out again.
>=20
> Alas, I don't have a particularly useful igt setup to test this
> properly, but I've left a couple of notes from trying it on my laptop
> here.

Thanks for the review, it=E2=80=99s much appreciated! If you have the =
time I=E2=80=99ve left a
note at the bottom with a very simple way to run the tests, but I can =
also
provide you with a pastebin of the results if you prefer.

>=20
>> lib/igt_kmod.c | 290 =
+++++++++++++++++++++++++++++++++++++++++++++++++
>> lib/igt_kmod.h |   2 +
>> 2 files changed, 292 insertions(+)
>>=20
>> diff --git a/lib/igt_kmod.c b/lib/igt_kmod.c
>> index 97cac7f5..93cdfcc5 100644
>> --- a/lib/igt_kmod.c
>> +++ b/lib/igt_kmod.c
>> @@ -25,6 +25,7 @@
>> #include <signal.h>
>> #include <errno.h>
>> #include <sys/utsname.h>
>> +#include <limits.h>
>>=20
>> #include "igt_aux.h"
>> #include "igt_core.h"
>> @@ -32,6 +33,8 @@
>> #include "igt_sysfs.h"
>> #include "igt_taints.h"
>>=20
>> +#define BUF_LEN 4096
>> +
>> /**
>>  * SECTION:igt_kmod
>>  * @short_description: Wrappers around libkmod for module =
loading/unloading
>> @@ -713,6 +716,293 @@ void igt_kselftest_get_tests(struct kmod_module =
*kmod,
>>        kmod_module_info_free_list(pre);
>> }
>>=20
>> +/**
>> + * lookup_value:
>> + * @haystack: the string to search in
>> + * @needle: the string to search for
>> + *
>> + * Returns: the value of the needle in the haystack, or -1 if not =
found.
>> + */
>> +static long lookup_value(const char *haystack, const char *needle)
>> +{
>> +       const char *needle_rptr;
>> +       char *needle_end;
>> +       long num;
>> +
>> +       needle_rptr =3D strcasestr(haystack, needle);
>> +
>> +       if (needle_rptr =3D=3D NULL)
>> +               return -1;
>> +
>> +       /* skip search string and whitespaces after it */
>> +       needle_rptr +=3D strlen(needle);
>> +
>> +       num =3D strtol(needle_rptr, &needle_end, 10);
>> +
>> +       if (needle_rptr =3D=3D needle_end)
>> +               return -1;
>> +
>> +       if (num =3D=3D LONG_MIN || num =3D=3D LONG_MAX)
>> +               return 0;
>> +
>> +       return num > 0 ? num : 0;
>> +}
>> +
>> +static int find_next_tap_subtest(char *record, char *test_name,
>> +                                bool is_subtest)
>> +{
>> +       const char *name_lookup_str,
>> +             *lend, *version_rptr, *name_rptr;
>> +       long test_count;
>> +
>> +       name_lookup_str =3D "test: ";
>> +
>> +       version_rptr =3D strcasestr(record, "TAP version ");
>> +       name_rptr =3D strcasestr(record, name_lookup_str);
>> +
>> +       /*
>> +        * total test count will almost always appear as 0..N at the =
beginning
>> +        * of a run, so we use it as indication of a run
>> +        */
>> +       test_count =3D lookup_value(record, "..");
>> +
>> +       /* no count found, so this is probably not starting a =
(sub)test */
>> +       if (test_count < 0) {
>> +               if (name_rptr !=3D NULL) {
>> +                       if (test_name[0] =3D=3D '\0')
>> +                               strncpy(test_name,
>> +                                       name_rptr + =
strlen(name_lookup_str),
>> +                                       BUF_LEN);
>> +                       else if (strcmp(test_name, name_rptr + =
strlen(name_lookup_str)) =3D=3D 0)
>> +                               return 0;
>> +                       else
>> +                               test_name[0] =3D '\0';
>> +
>> +               }
>> +               return -1;
>> +       }
>> +
>> +       /*
>> +        * "(K)TAP version XX" should be the first line on all =
(sub)tests as per
>> +        * =
https://www.kernel.org/doc/html/latest/dev-tools/ktap.html#version-lines
>> +        * but actually isn't, as it currently depends on whoever =
writes the
>> +        * test to print this info
>=20
> FYI: we're really trying to fix cases of "missing version lines",
> largely by making the kunit_test_suites() macro work in more
> circumstances.
>=20
> So while it may be worth still handling the case where this is
> missing, I don't think there are any tests in the latest versions of
> the kernel which should have this missing.

I=E2=80=99m not sure if I totally get how these work. Every time I run a =
KUnit test I
get something like this: https://pastebin.com/7Ff31PMC

As you can see it has been loaded as a module, just like we intend to do =
it
from IGT, and I see no version lines whatsoever. Am I doing something =
wrong?

>=20
>> +        */
>> +       if (version_rptr =3D=3D NULL)
>> +               igt_info("Missing test version string\n");
>> +
>> +       if (name_rptr =3D=3D NULL) {
>> +               /* we have to keep track of the name string, as it =
might be
>> +                * contained in a line read previously */
>> +               if (test_name[0] =3D=3D '\0') {
>> +                       igt_info("Missing test name string\n");
>> +
>> +                       if (is_subtest)
>> +                               igt_info("Running %ld subtests...\n", =
test_count);
>> +                       else
>> +                               igt_info("Running %ld tests...\n", =
test_count);
>> +               } else {
>> +                       lend =3D strchrnul(test_name, '\n');
>> +
>> +                       if (*lend =3D=3D '\0') {
>> +                               if (is_subtest)
>> +                                       igt_info("Executing %ld =
subtests in: %s\n",
>> +                                                test_count, =
test_name);
>> +                               else
>> +                                       igt_info("Executing %ld tests =
in: %s\n",
>> +                                                test_count, =
test_name);
>> +                               return test_count;
>> +                       }
>> +
>> +                       if (is_subtest)
>> +                               igt_info("Executing %ld subtests in: =
%.*s\n",
>> +                                        test_count, (int)(lend - =
test_name),
>> +                                        test_name);
>> +                       else
>> +                               igt_info("Executing %ld tests in: =
%.*s\n",
>> +                                        test_count, (int)(lend - =
test_name),
>> +                                        test_name);
>> +                       test_name[0] =3D '\0';
>> +               }
>> +       } else {
>> +               name_rptr +=3D strlen(name_lookup_str);
>> +               lend =3D strchrnul(name_rptr, '\n');
>> +               /*
>> +                * as the test count comes after the test name we =
need not check
>> +                * for a long line again
>> +                */
>> +               if (is_subtest)
>> +                       igt_info("Executing %ld subtests in: %.*s\n",
>> +                                test_count, (int)(lend - name_rptr),
>> +                                name_rptr);
>> +               else
>> +                       igt_info("Executing %ld tests in: %.*s\n",
>> +                                test_count, (int)(lend - name_rptr),
>> +                                name_rptr);
>> +       }
>> +
>> +       return test_count;
>> +}
>> +
>> +static void parse_kmsg_for_tap(const char *lstart, char *lend,
>> +                              int *sublevel, bool *failed_tests)
>> +{
>> +       const char *nok_rptr, *comment_start, *value_parse_start;
>> +
>> +       nok_rptr =3D strstr(lstart, "not ok ");
>> +       if (nok_rptr !=3D NULL) {
>> +               igt_warn("kmsg> %.*s\n",
>> +                        (int)(lend - lstart), lstart);
>> +               *failed_tests =3D true;
>> +               return;
>> +       }
>> +
>> +       comment_start =3D strchrnul(lstart, '#');
>> +
>> +       /* check if we're still in a subtest */
>> +       if (*comment_start !=3D '\0') {
>> +               comment_start++;
>> +               value_parse_start =3D comment_start;
>> +
>> +               if (lookup_value(value_parse_start, "fail: ") > 0) {
>> +                       igt_warn("kmsg> %.*s\n",
>> +                                (int)(lend - comment_start), =
comment_start);
>> +                       *failed_tests =3D true;
>> +                       (*sublevel)--;
>> +                       return;
>> +               }
>> +       }
>> +
>> +       igt_info("kmsg> %.*s\n",
>> +                (int)(lend - lstart), lstart);
>> +}
>> +
>> +static void igt_kunit_subtests(int fd, char *record,
>> +                              int *sublevel, bool *failed_tests)
>> +{
>> +       char test_name[BUF_LEN + 1], *lend;
>> +
>> +       lend =3D NULL;
>> +       test_name[0] =3D '\0';
>> +       test_name[BUF_LEN] =3D '\0';
>> +
>> +       while (*sublevel >=3D 0) {
>> +               const char *lstart;
>> +               ssize_t r;
>> +
>> +               if (lend !=3D NULL && *lend !=3D '\0')
>> +                       lseek(fd, (int) (lend - record), SEEK_CUR);
>> +
>> +               r =3D read(fd, record, BUF_LEN);
>> +
>> +               if (r <=3D 0) {
>> +                       switch (errno) {
>> +                       case EINTR:
>> +                               continue;
>> +                       case EPIPE:
>> +                               igt_warn("kmsg truncated: too many =
messages. \
>> +                                        You may want to increase =
log_buf_len \
>> +                                        in your boot options\n");
>> +                               continue;
>> +                       case !EAGAIN:
>> +                               igt_warn("kmsg truncated: unknown =
error (%m)\n");
>> +                               *sublevel =3D -1;
>> +                       default:
>> +                               break;
>> +                       }
>> +                       break;
>> +               }
>> +
>> +               lend =3D strchrnul(record, '\n');
>> +
>> +               /* in case line > 4096 */
>> +               if (*lend =3D=3D '\0')
>> +                       continue;
>> +
>> +               if (find_next_tap_subtest(record, test_name, =
*sublevel > 0) !=3D -1)
>> +                       (*sublevel)++;
>> +
>> +               if (*sublevel > 0) {
>> +                       lstart =3D strchrnul(record, ';');
>> +
>> +                       if (*lstart =3D=3D '\0') {
>> +                               igt_warn("kmsg truncated: output =
malformed (%m)\n");
>> +                               igt_fail(IGT_EXIT_FAILURE);
>> +                       }
>> +
>> +                       lstart++;
>> +                       while (isspace(*lstart))
>> +                               lstart++;
>> +
>> +                       parse_kmsg_for_tap(lstart, lend, sublevel, =
failed_tests);
>> +               }
>> +       }
>> +
>> +       if (*failed_tests || *sublevel < 0)
>> +               igt_fail(IGT_EXIT_FAILURE);
>> +       else
>> +               igt_success();
>> +}
>> +
>> +/**
>> + * igt_kunit:
>> + * @module_name: the name of the module
>> + * @opts: options to load the module
>> + *
>> + * Loads the kunit module, parses its dmesg output, then unloads it
>> + */
>> +void igt_kunit(const char *module_name, const char *opts)
>> +{
>> +       struct igt_ktest tst;
>> +       char record[BUF_LEN + 1];
>> +       bool failed_tests =3D false;
>> +       int sublevel =3D 0;
>> +
>> +       record[BUF_LEN] =3D '\0';
>> +
>> +       /* get normalized module name */
>> +       if (igt_ktest_init(&tst, module_name) !=3D 0) {
>> +               igt_warn("Unable to initialize ktest for %s\n", =
module_name);
>> +               return;
>> +       }
>> +
>> +       if (igt_ktest_begin(&tst) !=3D 0) {
>> +               igt_warn("Unable to begin ktest for %s\n", =
module_name);
>> +
>> +               igt_ktest_fini(&tst);
>> +               return;
>> +       }
>> +
>> +       if (tst.kmsg < 0) {
>> +               igt_warn("Could not open /dev/kmsg");
>> +               goto unload;
>> +       }
>> +
>> +       if (lseek(tst.kmsg, 0, SEEK_END)) {
>> +               igt_warn("Could not seek the end of /dev/kmsg");
>> +               goto unload;
>> +       }
>> +
>> +       /* The kunit module is required for running any kunit tests =
*/
>> +       if (igt_kmod_load("kunit", NULL) !=3D 0) {
>> +               igt_warn("Unable to load kunit module\n");
>> +               goto unload;
>> +       }
>=20
> Do you want to _require_ KUnit be built as a module, rather than =
built-in here?

This line is a little misleading because, for our purposes, only the =
thing to
be tested has to be built as a module, but we can use this function for =
both
validating a built-in module as well as modprobe-ing it if it's =
=E2=80=9Estandalone" (I
tested both cases as well). I=E2=80=99ll change the comment and the =
warning in v3
to clarify this.

The actual problem would be to unload something that=E2=80=99s built-in, =
so that=E2=80=99s why
I added a check in the unload function in the previous patch.

> Equally, does this need to mark a failure (or at least "SKIPPED")
> rather than success, in the case it fails.

That=E2=80=99s a good point, will change in v3.

>> +
>> +       if (igt_kmod_load(module_name, opts) !=3D 0) {
>> +               igt_warn("Unable to load %s module\n", module_name);
>> +               goto unload;
>> +       }
>=20
> As above, should this record a failure, or skip?

Ack.

>> +
>> +       igt_kunit_subtests(tst.kmsg, record, &sublevel, =
&failed_tests);
>> +unload:
>> +       igt_kmod_unload("kunit", 0);
>=20
> Do you want to unconditionally unload the KUnit module here? It's safe
> (maybe even safer) to leave it loaded between runs of KUnit tests.

That=E2=80=99s a great point. The user should be safe using KUnit as =
built-in in that
case, but I=E2=80=99ll remove this line as it is unnecessary.

> Equally, how would you handle the case where KUnit is already loaded?

That=E2=80=99s not a problem as pointed out above, kmod handles that =
without trouble.

>> +
>> +       igt_ktest_end(&tst);
>> +
>> +       igt_ktest_fini(&tst);
>> +}
>> +
>> static int open_parameters(const char *module_name)
>> {
>>        char path[256];
>> diff --git a/lib/igt_kmod.h b/lib/igt_kmod.h
>> index ceb10cd0..737143c1 100644
>> --- a/lib/igt_kmod.h
>> +++ b/lib/igt_kmod.h
>> @@ -45,6 +45,8 @@ int __igt_i915_driver_unload(char **whom);
>> int igt_amdgpu_driver_load(const char *opts);
>> int igt_amdgpu_driver_unload(void);
>>=20
>> +void igt_kunit(const char *module_name, const char *opts);
>> +
>> void igt_kselftests(const char *module_name,
>>                    const char *module_options,
>>                    const char *result_option,
>> --
>> 2.37.2
>>=20
>=20
> Regardless, thanks very much. Hopefully I'll get a chance to play with
> igt a bit more and actually get the tests running. :-)

That shouldn=E2=80=99t be too difficult, when you compile IGT as per the =
docs you can
just run e.g. `sudo ./build/tests/drm_buddy` and that should do it :).

Cheers,
--
Isabella Basso

>=20
> Cheers,
> -- David

