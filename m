Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B75BD5EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiISUz4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 16:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISUzz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 16:55:55 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5184B4A7;
        Mon, 19 Sep 2022 13:55:54 -0700 (PDT)
Received: from mx0.riseup.net (mx0-pn.riseup.net [10.0.1.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mx0.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MWcQd5Y3MzDq8s;
        Mon, 19 Sep 2022 20:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1663620953; bh=Y6zGMsGFdwFliQ3+RHU800xKasFHBJLooN5fF2cVeEU=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=ZcHItAFV8apkMKUmenyTBed1aftl/fsyMWE25cwHy0lYRtKsTxk8lstgj4v/ZWh6j
         ZeQWSrlZanergzuTDkxA9ZNZc7I0I2xdVmZ/V4scIrD/MKg9mCnj/qaldLix4S/sJ8
         +jk2iciujpqjZeyqKiF4gR/pAiSMPrxlSpp9Hm2g=
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4MWcQc5SPsz9sNF;
        Mon, 19 Sep 2022 20:55:52 +0000 (UTC)
X-Riseup-User-ID: 13F53709CB8123FC955927105016AA312A7F55A7E5F644F5CB03E89423DB5C1F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4MWcQW4s8Wz5vW6;
        Mon, 19 Sep 2022 20:55:47 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [igt-dev] [PATCH i-g-t v2 3/4] lib/igt_kmod: add compatibility
 for KUnit
From:   Isabella Basso <isabbasso@riseup.net>
In-Reply-To: <2101392.KlZ2vcFHjT@jkrzyszt-mobl1.ger.corp.intel.com>
Date:   Mon, 19 Sep 2022 17:55:44 -0300
Cc:     igt-dev@lists.freedesktop.org, linux-kselftest@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        =?utf-8?Q?Ma=C3=ADra_Canal?= <maira.canal@usp.br>,
        Daniel Latypov <dlatypov@google.com>, n@nfraprado.net,
        kernel list <linux-kernel@vger.kernel.org>,
        leandro.ribeiro@collabora.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Gow <davidgow@google.com>,
        Tales Aparecida <tales.aparecida@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        =?utf-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>,
        Brendan Higgins <brendanhiggins@google.com>,
        Trevor Woerner <twoerner@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <66E07FE6-0FE1-4CDF-A346-CF23C7B9D073@riseup.net>
References: <20220829000920.38185-1-isabbasso@riseup.net>
 <20220829000920.38185-4-isabbasso@riseup.net>
 <2101392.KlZ2vcFHjT@jkrzyszt-mobl1.ger.corp.intel.com>
To:     Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Janusz,

> Am 09/09/2022 um 12:18 PM schrieb Janusz Krzysztofik =
<janusz.krzysztofik@linux.intel.com>:
>=20
> Hi Isabella,
>=20
> On Monday, 29 August 2022 02:09:19 CEST Isabella Basso wrote:
>> This adds functions for both executing the tests as well as parsing =
(K)TAP
>> kmsg output, as per the KTAP spec [1].
>>=20
>> [1] https://www.kernel.org/doc/html/latest/dev-tools/ktap.html
>>=20
>> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
>> ---
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
>> 	kmod_module_info_free_list(pre);
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
>> +	const char *needle_rptr;
>> +	char *needle_end;
>> +	long num;
>> +
>> +	needle_rptr =3D strcasestr(haystack, needle);
>> +
>> +	if (needle_rptr =3D=3D NULL)
>> +		return -1;
>> +
>> +	/* skip search string and whitespaces after it */
>> +	needle_rptr +=3D strlen(needle);
>> +
>> +	num =3D strtol(needle_rptr, &needle_end, 10);
>> +
>> +	if (needle_rptr =3D=3D needle_end)
>> +		return -1;
>> +
>> +	if (num =3D=3D LONG_MIN || num =3D=3D LONG_MAX)
>> +		return 0;
>> +
>> +	return num > 0 ? num : 0;
>> +}
>> +
>> +static int find_next_tap_subtest(char *record, char *test_name,
>> +				 bool is_subtest)
>> +{
>> +	const char *name_lookup_str,
>> +	      *lend, *version_rptr, *name_rptr;
>> +	long test_count;
>> +
>> +	name_lookup_str =3D "test: ";
>> +
>> +	version_rptr =3D strcasestr(record, "TAP version ");
>> +	name_rptr =3D strcasestr(record, name_lookup_str);
>> +
>> +	/*
>> +	 * total test count will almost always appear as 0..N at the =
beginning
>> +	 * of a run, so we use it as indication of a run
>> +	 */
>> +	test_count =3D lookup_value(record, "..");
>> +
>> +	/* no count found, so this is probably not starting a (sub)test =
*/
>> +	if (test_count < 0) {
>> +		if (name_rptr !=3D NULL) {
>> +			if (test_name[0] =3D=3D '\0')
>> +				strncpy(test_name,
>> +					name_rptr + =
strlen(name_lookup_str),
>> +					BUF_LEN);
>> +			else if (strcmp(test_name, name_rptr + =
strlen(name_lookup_str)) =3D=3D 0)
>> +				return 0;
>> +			else
>> +				test_name[0] =3D '\0';
>> +
>> +		}
>> +		return -1;
>> +	}
>> +
>> +	/*
>> +	 * "(K)TAP version XX" should be the first line on all =
(sub)tests as per
>> +	 * =
https://www.kernel.org/doc/html/latest/dev-tools/ktap.html#version-lines
>> +	 * but actually isn't, as it currently depends on whoever writes =
the
>> +	 * test to print this info
>> +	 */
>> +	if (version_rptr =3D=3D NULL)
>> +		igt_info("Missing test version string\n");
>> +
>> +	if (name_rptr =3D=3D NULL) {
>> +		/* we have to keep track of the name string, as it might =
be
>> +		 * contained in a line read previously */
>> +		if (test_name[0] =3D=3D '\0') {
>> +			igt_info("Missing test name string\n");
>> +
>> +			if (is_subtest)
>> +				igt_info("Running %ld subtests...\n", =
test_count);
>> +			else
>> +				igt_info("Running %ld tests...\n", =
test_count);
>> +		} else {
>> +			lend =3D strchrnul(test_name, '\n');
>> +
>> +			if (*lend =3D=3D '\0') {
>> +				if (is_subtest)
>> +					igt_info("Executing %ld subtests =
in: %s\n",
>> +						 test_count, test_name);
>> +				else
>> +					igt_info("Executing %ld tests =
in: %s\n",
>> +						 test_count, test_name);
>> +				return test_count;
>> +			}
>> +
>> +			if (is_subtest)
>> +				igt_info("Executing %ld subtests in: =
%.*s\n",
>> +					 test_count, (int)(lend - =
test_name),
>> +					 test_name);
>> +			else
>> +				igt_info("Executing %ld tests in: =
%.*s\n",
>> +					 test_count, (int)(lend - =
test_name),
>> +					 test_name);
>> +			test_name[0] =3D '\0';
>> +		}
>> +	} else {
>> +		name_rptr +=3D strlen(name_lookup_str);
>> +		lend =3D strchrnul(name_rptr, '\n');
>> +		/*
>> +		 * as the test count comes after the test name we need =
not check
>> +		 * for a long line again
>> +		 */
>> +		if (is_subtest)
>> +			igt_info("Executing %ld subtests in: %.*s\n",
>> +				 test_count, (int)(lend - name_rptr),
>> +				 name_rptr);
>> +		else
>> +			igt_info("Executing %ld tests in: %.*s\n",
>> +				 test_count, (int)(lend - name_rptr),
>> +				 name_rptr);
>> +	}
>> +
>> +	return test_count;
>> +}
>> +
>> +static void parse_kmsg_for_tap(const char *lstart, char *lend,
>> +			       int *sublevel, bool *failed_tests)
>> +{
>> +	const char *nok_rptr, *comment_start, *value_parse_start;
>> +
>> +	nok_rptr =3D strstr(lstart, "not ok ");
>> +	if (nok_rptr !=3D NULL) {
>> +		igt_warn("kmsg> %.*s\n",
>> +			 (int)(lend - lstart), lstart);
>> +		*failed_tests =3D true;
>> +		return;
>> +	}
>> +
>> +	comment_start =3D strchrnul(lstart, '#');
>> +
>> +	/* check if we're still in a subtest */
>> +	if (*comment_start !=3D '\0') {
>> +		comment_start++;
>> +		value_parse_start =3D comment_start;
>> +
>> +		if (lookup_value(value_parse_start, "fail: ") > 0) {
>> +			igt_warn("kmsg> %.*s\n",
>> +				 (int)(lend - comment_start), =
comment_start);
>> +			*failed_tests =3D true;
>> +			(*sublevel)--;
>> +			return;
>> +		}
>> +	}
>> +
>> +	igt_info("kmsg> %.*s\n",
>> +		 (int)(lend - lstart), lstart);
>> +}
>> +
>> +static void igt_kunit_subtests(int fd, char *record,
>> +			       int *sublevel, bool *failed_tests)
>=20
> This function looks like nothing but a KTAP parser.  It doesn't =
perform any=20
> operations required for execution of kunit tests.  Shouldn't we better =
name it=20
> like igt_ktap_parser or something like that?  Besides, I would move =
that=20
> parser code to a separate source file.
>=20
>> +{
>> +	char test_name[BUF_LEN + 1], *lend;
>> +
>> +	lend =3D NULL;
>> +	test_name[0] =3D '\0';
>> +	test_name[BUF_LEN] =3D '\0';
>> +
>> +	while (*sublevel >=3D 0) {
>> +		const char *lstart;
>> +		ssize_t r;
>> +
>> +		if (lend !=3D NULL && *lend !=3D '\0')
>> +			lseek(fd, (int) (lend - record), SEEK_CUR);
>> +
>> +		r =3D read(fd, record, BUF_LEN);
>> +
>> +		if (r <=3D 0) {
>> +			switch (errno) {
>> +			case EINTR:
>> +				continue;
>> +			case EPIPE:
>> +				igt_warn("kmsg truncated: too many =
messages. \
>> +					 You may want to increase =
log_buf_len \
>> +					 in your boot options\n");
>> +				continue;
>> +			case !EAGAIN:
>> +				igt_warn("kmsg truncated: unknown error =
(%m)\n");something=20
>=20
> If the intention here is to display this warning only in other cases =
but=20
> EAGAIN error then that won't work as intended.
>=20
>> +				*sublevel =3D -1;
>=20
> Shouldn't *sublevel be also set to -1 in all cases but EINTR and =
EPIPE,=20
> whether EAGAIN or anything else?
>=20
> Other than that, please use /* fallthrough */ marking if you =
intentionally=20
> omit break;
>=20
>> +			default:
>> +				break;
>> +			}
>> +			break;
>> +		}
>> +
>> +		lend =3D strchrnul(record, '\n');
>> +
>> +		/* in case line > 4096 */
>> +		if (*lend =3D=3D '\0')
>> +			continue;
>=20
> That means we are free to ignore initial fragments of lines exceeding =
4096=20
> characters, but still will be looking at trailing fragments of those =
lines. =20
> This approach seems sub-optimal to me.  Wouldn't it be more convenient =
if we=20
> used line buffered I/O instead of read()?
>=20
>> +
>> +		if (find_next_tap_subtest(record, test_name, *sublevel > =
0) !=3D -1)
>> +			(*sublevel)++;
>> +
>> +		if (*sublevel > 0) {
>> +			lstart =3D strchrnul(record, ';');
>> +
>> +			if (*lstart =3D=3D '\0') {
>> +				igt_warn("kmsg truncated: output =
malformed (%m)\n");
>> +				igt_fail(IGT_EXIT_FAILURE);
>> +			}
>> +
>> +			lstart++;
>> +			while (isspace(*lstart))
>> +				lstart++;
>> +
>> +			parse_kmsg_for_tap(lstart, lend, sublevel, =
failed_tests);
>> +		}
>> +	}
>> +
>> +	if (*failed_tests || *sublevel < 0)
>> +		igt_fail(IGT_EXIT_FAILURE);
>> +	else
>> +		igt_success();
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
>> +	struct igt_ktest tst;
>> +	char record[BUF_LEN + 1];
>> +	bool failed_tests =3D false;
>> +	int sublevel =3D 0;
>> +
>> +	record[BUF_LEN] =3D '\0';
>> +
>> +	/* get normalized module name */
>> +	if (igt_ktest_init(&tst, module_name) !=3D 0) {
>> +		igt_warn("Unable to initialize ktest for %s\n", =
module_name);
>> +		return;
>> +	}
>> +
>> +	if (igt_ktest_begin(&tst) !=3D 0) {
>=20
> Since igt_ktest_begin() as is calls igt_require() then it may be used =
only=20
> from inside an igt_fixture or igt_subtest block.  If the intention is =
to call
> igt_kunit() from an igt_subtest block, unlike igt_kselftest() which =
has=20
> igt_fixture and igt_subtest blocks placed in its body, please document =
that.
>=20
>> +		igt_warn("Unable to begin ktest for %s\n", module_name);
>> +
>> +		igt_ktest_fini(&tst);
>> +		return;
>> +	}
>> +
>> +	if (tst.kmsg < 0) {
>> +		igt_warn("Could not open /dev/kmsg");
>> +		goto unload;
>> +	}
>> +
>> +	if (lseek(tst.kmsg, 0, SEEK_END)) {
>> +		igt_warn("Could not seek the end of /dev/kmsg");
>> +		goto unload;
>> +	}
>> +
>> +	/* The kunit module is required for running any kunit tests */
>> +	if (igt_kmod_load("kunit", NULL) !=3D 0) {
>> +		igt_warn("Unable to load kunit module\n");
>> +		goto unload;
>> +	}
>> +
>> +	if (igt_kmod_load(module_name, opts) !=3D 0) {
>> +		igt_warn("Unable to load %s module\n", module_name);
>> +		goto unload;
>> +	}
>> +
>> +	igt_kunit_subtests(tst.kmsg, record, &sublevel, &failed_tests);
>=20
> What's the point of passing that many temporary variable pointers to=20=

> igt_kunit_subtests() if we are not interested here in content of any =
of those=20
> variables after the function returns?  That function could perfectly =
use its=20
> own local variables for storing that data.
>=20
> Besides, my comment about not using igt_require() outside of =
igt_fixture or=20
> igt_subtest blocks also applies to igt_fail() and igt_success() called =
from
> igt_kunit_subtests().
>=20
> Anyway, related to my comment about naming that function a parser, I =
think the=20
> best approach would be for that parser to return a generic set of =
results from=20
> kunit execution, then we could feed that data into an IGT specific =
handler=20
> that would convert them to IGT results (SUCCESS, FAIL, or SKIP) as if =
returned=20
> by a set of IGT dynamic subtests.

That sounds like a good idea to me, I might take some extra time before =
v3 to
do that, though. I=E2=80=99ll also look into your other suggestions =
carefully.

Thanks a lot for the review!

Cheers,
--
Isabella Basso

> Thanks,
> Janusz
>=20
>> +unload:
>> +	igt_kmod_unload("kunit", 0);
>> +
>> +	igt_ktest_end(&tst);
>> +
>> +	igt_ktest_fini(&tst);
>> +}
>> +
>> static int open_parameters(const char *module_name)
>> {
>> 	char path[256];
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
>> 		    const char *module_options,
>> 		    const char *result_option,
>>=20

