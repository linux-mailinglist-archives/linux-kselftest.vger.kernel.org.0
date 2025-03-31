Return-Path: <linux-kselftest+bounces-29960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 088EAA76DD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 22:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC283AAD6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCD421481D;
	Mon, 31 Mar 2025 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FmQiax15"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8317C8472;
	Mon, 31 Mar 2025 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451244; cv=none; b=Y8qoghvhNhr9o7gV+l4myNhfMLzaThtvycjbJGJpvPECfbDINVSRjw1NG+QG4KQJfFFSCfyGsIaqGHxuVsXuMO6ESCctF4NDdUjLyD8tAQ5ojB9PVyMPdAXgz1pUGukkBG+6IwidfPlAeaDunoACpBzuzZHygWUqpj8gk0LD8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451244; c=relaxed/simple;
	bh=LJ2pLNX9/A/YnCNJEv8/2x5aDNTiy3gQMHFL8Gu0AKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DTn256bNxmoMUudwCAtchZT8b9yAbMSkDsEJTe3lKn1LQQwZA9mm9D2/M4hU2t6Kf5QuwPJCKm1KgjKz87ik7fkXT8GmcnGdEmXB//zr/LOXEXekVQzusSQ+6o6sEUmg/C7VZd6A+8d2Dt7UffNk6VYeE1rU0OgORRWw44bB2SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FmQiax15; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from narnia (unknown [167.220.2.28])
	by linux.microsoft.com (Postfix) with ESMTPSA id 522DD210237E;
	Mon, 31 Mar 2025 13:00:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 522DD210237E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743451241;
	bh=fIovqkBitXFZRQ//g6BuZpszSPejDeke8e/+BQorTCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FmQiax15Emr+HO7GFbg654Oa6oexdb9pXvdUjsUZpIuu42L0xy5p8WDzlIIDrG/5j
	 ySOAeVcw/6yTfRgtP2xHcP8ETiFgVFrNvK7H7oHiVccAXOOgoXWtE+mxyv6C9E+s0s
	 hnuUi9mndmMldFbdQMO+EDIff98hHWYURD2ixY18=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
 <davem@davemloft.net>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas
 Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>, =?utf-8?Q?Mick?=
 =?utf-8?Q?a=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Nick
 Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jan Stancek <jstancek@redhat.com>,
 Neal Gompa <neal@gompa.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, llvm@lists.linux.dev, nkapron@google.com,
 teknoraver@meta.com, roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 2/4] hornet: Introduce sign-ebpf
In-Reply-To: <Z97y578XhzkTt0mK@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <20250321164537.16719-3-bboscaccy@linux.microsoft.com>
 <Z97y578XhzkTt0mK@kernel.org>
Date: Mon, 31 Mar 2025 13:00:29 -0700
Message-ID: <87cydx6kde.fsf@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jarkko Sakkinen <jarkko@kernel.org> writes:

> On Fri, Mar 21, 2025 at 09:45:04AM -0700, Blaise Boscaccy wrote:
>> This introduces the sign-ebpf tool. It is very similar to the existing
>> sign-file script, with one key difference, it will sign a file with
>> with a signature computed off of arbitrary input data. This can used
>> to sign an ebpf light skeleton loader program for verification via
>> hornet.
>>=20
>> Typical usage is to provide a payload containing the lskel ebpf
>> syscall program binary and it's associated maps, which can be
>> extracted from the auto-generated skel header.
>>=20
>> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>> ---
>>  scripts/Makefile           |   1 +
>>  scripts/hornet/Makefile    |   5 +
>>  scripts/hornet/sign-ebpf.c | 420 +++++++++++++++++++++++++++++++++++++
>>  3 files changed, 426 insertions(+)
>>  create mode 100644 scripts/hornet/Makefile
>>  create mode 100644 scripts/hornet/sign-ebpf.c
>>=20
>> diff --git a/scripts/Makefile b/scripts/Makefile
>> index 46f860529df5e..a2cace05d7342 100644
>> --- a/scripts/Makefile
>> +++ b/scripts/Makefile
>> @@ -57,6 +57,7 @@ subdir-$(CONFIG_GENKSYMS) +=3D genksyms
>>  subdir-$(CONFIG_GENDWARFKSYMS) +=3D gendwarfksyms
>>  subdir-$(CONFIG_SECURITY_SELINUX) +=3D selinux
>>  subdir-$(CONFIG_SECURITY_IPE) +=3D ipe
>> +subdir-$(CONFIG_SECURITY_HORNET) +=3D hornet
>>=20=20
>>  # Let clean descend into subdirs
>>  subdir-	+=3D basic dtc gdb kconfig mod
>> diff --git a/scripts/hornet/Makefile b/scripts/hornet/Makefile
>> new file mode 100644
>> index 0000000000000..ab71dbb8688e4
>> --- /dev/null
>> +++ b/scripts/hornet/Makefile
>> @@ -0,0 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +hostprogs-always-y	:=3D sign-ebpf
>> +
>> +HOSTCFLAGS_sign-ebpf.o =3D $(shell $(HOSTPKG_CONFIG) --cflags libcrypto=
 2> /dev/null)
>> +HOSTLDLIBS_sign-ebpf =3D $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> =
/dev/null || echo -lcrypto)
>> diff --git a/scripts/hornet/sign-ebpf.c b/scripts/hornet/sign-ebpf.c
>> new file mode 100644
>> index 0000000000000..ff98fddb79a15
>> --- /dev/null
>> +++ b/scripts/hornet/sign-ebpf.c
>> @@ -0,0 +1,420 @@
>> +/* Sign ebpf programs and skeletons using the given key.
>> + *
>> + * This program is heavily based on the kernel's sign-file tool
>> + * with some minor additions to support the signing of eBPF lskels.
>> + *
>> + * Copyright =C2=A9 2014-2016 Red Hat, Inc. All Rights Reserved.
>> + * Copyright =C2=A9 2015      Intel Corporation.
>> + * Copyright =C2=A9 2016      Hewlett Packard Enterprise Development LP
>> + * Copyright =C2=A9 2025      Microsoft Corporation.
>> + *
>> + * Authors: David Howells <dhowells@redhat.com>
>> + *          David Woodhouse <dwmw2@infradead.org>
>> + *          Juerg Haefliger <juerg.haefliger@hpe.com>
>> + *          Blaise Boscaccy <bboscaccy@linux.microsoft.com>
>
> I don't think that for new code ad-hoc authors lists in source code
> make any sense.
>
>

I'll remove that. This script is mostly copy-paste of sign-file with
some new args and usage. I'll leave the copywrite and nuke the author
list.=20

>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU Lesser General Public License
>> + * as published by the Free Software Foundation; either version 2.1
>> + * of the licence, or (at your option) any later version.
>
> Redundant given SPDX.
>

Sounds good.=20

>> + */
>> +#define _GNU_SOURCE
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <stdint.h>
>> +#include <stdbool.h>
>> +#include <string.h>
>> +#include <getopt.h>
>> +#include <err.h>
>> +#include <arpa/inet.h>
>> +#include <openssl/opensslv.h>
>> +#include <openssl/bio.h>
>> +#include <openssl/evp.h>
>> +#include <openssl/pem.h>
>> +#include <openssl/err.h>
>> +#if OPENSSL_VERSION_MAJOR >=3D 3
>> +# define USE_PKCS11_PROVIDER
>> +# include <openssl/provider.h>
>> +# include <openssl/store.h>
>> +#else
>> +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
>> +#  define USE_PKCS11_ENGINE
>> +#  include <openssl/engine.h>
>> +# endif
>> +#endif
>> +#include "../ssl-common.h"
>> +
>> +/*
>> + * Use CMS if we have openssl-1.0.0 or newer available - otherwise we h=
ave to
>> + * assume that it's not available and its header file is missing and th=
at we
>> + * should use PKCS#7 instead.  Switching to the older PKCS#7 format res=
tricts
>> + * the options we have on specifying the X.509 certificate we want.
>> + *
>> + * Further, older versions of OpenSSL don't support manually adding sig=
ners to
>> + * the PKCS#7 message so have to accept that we get a certificate inclu=
ded in
>> + * the signature message.  Nor do such older versions of OpenSSL support
>> + * signing with anything other than SHA1 - so we're stuck with that if =
such is
>> + * the case.
>> + */
>> +#if defined(LIBRESSL_VERSION_NUMBER) || \
>> +	OPENSSL_VERSION_NUMBER < 0x10000000L || \
>> +	defined(OPENSSL_NO_CMS)
>> +#define USE_PKCS7
>> +#endif
>> +#ifndef USE_PKCS7
>> +#include <openssl/cms.h>
>> +#else
>> +#include <openssl/pkcs7.h>
>> +#endif
>> +
>> +struct module_signature {
>> +	uint8_t		algo;		/* Public-key crypto algorithm [0] */
>> +	uint8_t		hash;		/* Digest algorithm [0] */
>> +	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
>> +	uint8_t		signer_len;	/* Length of signer's name [0] */
>> +	uint8_t		key_id_len;	/* Length of key identifier [0] */
>> +	uint8_t		__pad[3];
>> +	uint32_t	sig_len;	/* Length of signature data */
>> +};
>> +
>> +#define PKEY_ID_PKCS7 2
>> +
>> +static char magic_number[] =3D "~eBPF signature appended~\n";
>> +
>> +static __attribute__((noreturn))
>> +void format(void)
>> +{
>> +	fprintf(stderr,
>> +		"Usage: scripts/sign-ebpf [-dp] <hash algo> <key> <x509> <bin> <loade=
r> [<dest>]\n");
>> +	exit(2);
>> +}
>> +
>> +static const char *key_pass;
>> +
>> +static int pem_pw_cb(char *buf, int len, int w, void *v)
>> +{
>> +	int pwlen;
>> +
>> +	if (!key_pass)
>> +		return -1;
>> +
>> +	pwlen =3D strlen(key_pass);
>> +	if (pwlen >=3D len)
>> +		return -1;
>> +
>> +	strcpy(buf, key_pass);
>> +
>> +	/* If it's wrong, don't keep trying it. */
>> +	key_pass =3D NULL;
>> +
>> +	return pwlen;
>> +}
>> +
>> +static EVP_PKEY *read_private_key_pkcs11(const char *private_key_name)
>> +{
>> +	EVP_PKEY *private_key =3D NULL;
>> +#ifdef USE_PKCS11_PROVIDER
>> +	OSSL_STORE_CTX *store;
>> +
>> +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
>> +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
>> +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
>> +		ERR(1, "OSSL_PROVIDER_try_load(default)");
>> +
>> +	store =3D OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
>> +	ERR(!store, "OSSL_STORE_open");
>> +
>> +	while (!OSSL_STORE_eof(store)) {
>> +		OSSL_STORE_INFO *info =3D OSSL_STORE_load(store);
>> +
>> +		if (!info) {
>> +			drain_openssl_errors(__LINE__, 0);
>> +			continue;
>> +		}
>> +		if (OSSL_STORE_INFO_get_type(info) =3D=3D OSSL_STORE_INFO_PKEY) {
>> +			private_key =3D OSSL_STORE_INFO_get1_PKEY(info);
>> +			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
>> +		}
>> +		OSSL_STORE_INFO_free(info);
>> +		if (private_key)
>> +			break;
>> +	}
>> +	OSSL_STORE_close(store);
>> +#elif defined(USE_PKCS11_ENGINE)
>> +	ENGINE *e;
>> +
>> +	ENGINE_load_builtin_engines();
>> +	drain_openssl_errors(__LINE__, 1);
>> +	e =3D ENGINE_by_id("pkcs11");
>> +	ERR(!e, "Load PKCS#11 ENGINE");
>> +	if (ENGINE_init(e))
>> +		drain_openssl_errors(__LINE__, 1);
>> +	else
>> +		ERR(1, "ENGINE_init");
>> +	if (key_pass)
>> +		ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN"=
);
>> +	private_key =3D ENGINE_load_private_key(e, private_key_name, NULL, NUL=
L);
>> +	ERR(!private_key, "%s", private_key_name);
>> +#else
>> +	fprintf(stderr, "no pkcs11 engine/provider available\n");
>> +	exit(1);
>> +#endif
>> +	return private_key;
>> +}
>> +
>> +static EVP_PKEY *read_private_key(const char *private_key_name)
>> +{
>> +	if (!strncmp(private_key_name, "pkcs11:", 7)) {
>> +		return read_private_key_pkcs11(private_key_name);
>> +	} else {
>> +		EVP_PKEY *private_key;
>> +		BIO *b;
>> +
>> +		b =3D BIO_new_file(private_key_name, "rb");
>> +		ERR(!b, "%s", private_key_name);
>> +		private_key =3D PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
>> +						      NULL);
>> +		ERR(!private_key, "%s", private_key_name);
>> +		BIO_free(b);
>> +
>> +		return private_key;
>> +	}
>> +}
>> +
>> +static X509 *read_x509(const char *x509_name)
>> +{
>> +	unsigned char buf[2];
>> +	X509 *x509;
>> +	BIO *b;
>> +	int n;
>> +
>> +	b =3D BIO_new_file(x509_name, "rb");
>> +	ERR(!b, "%s", x509_name);
>> +
>> +	/* Look at the first two bytes of the file to determine the encoding */
>> +	n =3D BIO_read(b, buf, 2);
>> +	if (n !=3D 2) {
>> +		if (BIO_should_retry(b)) {
>> +			fprintf(stderr, "%s: Read wanted retry\n", x509_name);
>> +			exit(1);
>> +		}
>> +		if (n >=3D 0) {
>> +			fprintf(stderr, "%s: Short read\n", x509_name);
>> +			exit(1);
>> +		}
>> +		ERR(1, "%s", x509_name);
>> +	}
>> +
>> +	ERR(BIO_reset(b) !=3D 0, "%s", x509_name);
>> +
>> +	if (buf[0] =3D=3D 0x30 && buf[1] >=3D 0x81 && buf[1] <=3D 0x84)
>> +		/* Assume raw DER encoded X.509 */
>> +		x509 =3D d2i_X509_bio(b, NULL);
>> +	else
>> +		/* Assume PEM encoded X.509 */
>> +		x509 =3D PEM_read_bio_X509(b, NULL, NULL, NULL);
>> +
>> +	BIO_free(b);
>> +	ERR(!x509, "%s", x509_name);
>> +
>> +	return x509;
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	struct module_signature sig_info =3D { .id_type =3D PKEY_ID_PKCS7 };
>> +	char *hash_algo =3D NULL;
>> +	char *private_key_name =3D NULL, *raw_sig_name =3D NULL;
>> +	char *x509_name, *bin_name, *loader_name, *dest_name;
>> +	bool save_sig =3D false, replace_orig;
>> +	bool sign_only =3D false;
>> +	bool raw_sig =3D false;
>> +	unsigned char buf[4096];
>> +	unsigned long loader_size, sig_size;
>> +	unsigned int use_signed_attrs;
>> +	const EVP_MD *digest_algo;
>> +	EVP_PKEY *private_key;
>> +#ifndef USE_PKCS7
>> +	CMS_ContentInfo *cms =3D NULL;
>> +	unsigned int use_keyid =3D 0;
>> +#else
>> +	PKCS7 *pkcs7 =3D NULL;
>> +#endif
>> +	X509 *x509;
>> +	BIO *bd, *bm, *bl;
>> +	int opt, n;
>> +	OpenSSL_add_all_algorithms();
>> +	ERR_load_crypto_strings();
>> +	ERR_clear_error();
>> +
>> +	key_pass =3D getenv("KBUILD_SIGN_PIN");
>> +
>> +#ifndef USE_PKCS7
>> +	use_signed_attrs =3D CMS_NOATTR;
>> +#else
>> +	use_signed_attrs =3D PKCS7_NOATTR;
>> +#endif
>> +
>> +	do {
>> +		opt =3D getopt(argc, argv, "sdpk");
>> +		switch (opt) {
>> +		case 's': raw_sig =3D true; break;
>> +		case 'p': save_sig =3D true; break;
>> +		case 'd': sign_only =3D true; save_sig =3D true; break;
>> +#ifndef USE_PKCS7
>> +		case 'k': use_keyid =3D CMS_USE_KEYID; break;
>> +#endif
>> +		case -1: break;
>> +		default: format();
>> +		}
>> +	} while (opt !=3D -1);
>> +
>> +	argc -=3D optind;
>> +	argv +=3D optind;
>> +	if (argc < 5 || argc > 6)
>> +		format();
>> +
>> +	if (raw_sig) {
>> +		raw_sig_name =3D argv[0];
>> +		hash_algo =3D argv[1];
>> +	} else {
>> +		hash_algo =3D argv[0];
>> +		private_key_name =3D argv[1];
>> +	}
>> +	x509_name =3D argv[2];
>> +	bin_name =3D argv[3];
>> +	loader_name =3D argv[4];
>> +	if (argc =3D=3D 6 && strcmp(argv[4], argv[5]) !=3D 0) {
>> +		dest_name =3D argv[5];
>> +		replace_orig =3D false;
>> +	} else {
>> +		ERR(asprintf(&dest_name, "%s.~signed~", loader_name) < 0,
>> +		    "asprintf");
>> +		replace_orig =3D true;
>> +	}
>> +
>> +#ifdef USE_PKCS7
>> +	if (strcmp(hash_algo, "sha1") !=3D 0) {
>> +		fprintf(stderr, "sign-file: %s only supports SHA1 signing\n",
>> +			OPENSSL_VERSION_TEXT);
>> +		exit(3);
>> +	}
>> +#endif
>> +
>> +	/* Open the bin file */
>> +	bm =3D BIO_new_file(bin_name, "rb");
>> +	ERR(!bm, "%s", bin_name);
>> +
>> +	if (!raw_sig) {
>> +		/* Read the private key and the X.509 cert the PKCS#7 message
>> +		 * will point to.
>> +		 */
>> +		private_key =3D read_private_key(private_key_name);
>> +		x509 =3D read_x509(x509_name);
>> +
>> +		/* Digest the module data. */
>> +		OpenSSL_add_all_digests();
>> +		drain_openssl_errors(__LINE__, 0);
>> +		digest_algo =3D EVP_get_digestbyname(hash_algo);
>> +		ERR(!digest_algo, "EVP_get_digestbyname");
>> +
>> +#ifndef USE_PKCS7
>> +		/* Load the signature message from the digest buffer. */
>> +		cms =3D CMS_sign(NULL, NULL, NULL, NULL,
>> +			       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
>> +			       CMS_DETACHED | CMS_STREAM);
>> +		ERR(!cms, "CMS_sign");
>> +
>> +		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
>> +				     CMS_NOCERTS | CMS_BINARY |
>> +				     CMS_NOSMIMECAP | use_keyid |
>> +				     use_signed_attrs),
>> +		    "CMS_add1_signer");
>> +		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) !=3D 1,
>> +		    "CMS_final");
>> +
>> +#else
>> +		pkcs7 =3D PKCS7_sign(x509, private_key, NULL, bm,
>> +				   PKCS7_NOCERTS | PKCS7_BINARY |
>> +				   PKCS7_DETACHED | use_signed_attrs);
>> +		ERR(!pkcs7, "PKCS7_sign");
>> +#endif
>> +
>> +		if (save_sig) {
>> +			char *sig_file_name;
>> +			BIO *b;
>> +
>> +			ERR(asprintf(&sig_file_name, "%s.p7s", bin_name) < 0,
>> +			    "asprintf");
>> +			b =3D BIO_new_file(sig_file_name, "wb");
>> +			ERR(!b, "%s", sig_file_name);
>> +#ifndef USE_PKCS7
>> +			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) !=3D 1,
>> +			    "%s", sig_file_name);
>> +#else
>> +			ERR(i2d_PKCS7_bio(b, pkcs7) !=3D 1,
>> +			    "%s", sig_file_name);
>> +#endif
>> +			BIO_free(b);
>> +		}
>> +
>> +		if (sign_only) {
>> +			BIO_free(bm);
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	/* Open the destination file now so that we can shovel the loader data
>> +	 * across as we read it.
>> +	 */
>> +	bd =3D BIO_new_file(dest_name, "wb");
>> +	ERR(!bd, "%s", dest_name);
>> +
>> +	bl =3D BIO_new_file(loader_name, "rb");
>> +	ERR(!bl, "%s", loader_name);
>> +
>> +
>> +	/* Append the marker and the PKCS#7 message to the destination file */
>> +	ERR(BIO_reset(bm) < 0, "%s", bin_name);
>> +	ERR(BIO_reset(bl) < 0, "%s", loader_name);
>> +	while ((n =3D BIO_read(bl, buf, sizeof(buf))),
>> +	       n > 0) {
>> +		ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
>> +	}
>> +	BIO_free(bl);
>> +	BIO_free(bm);
>> +	ERR(n < 0, "%s", loader_name);
>> +	loader_size =3D BIO_number_written(bd);
>> +
>> +	if (!raw_sig) {
>> +#ifndef USE_PKCS7
>> +		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) !=3D 1, "%s", dest_name);
>> +#else
>> +		ERR(i2d_PKCS7_bio(bd, pkcs7) !=3D 1, "%s", dest_name);
>> +#endif
>> +	} else {
>> +		BIO *b;
>> +
>> +		/* Read the raw signature file and write the data to the
>> +		 * destination file
>> +		 */
>> +		b =3D BIO_new_file(raw_sig_name, "rb");
>> +		ERR(!b, "%s", raw_sig_name);
>> +		while ((n =3D BIO_read(b, buf, sizeof(buf))), n > 0)
>> +			ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
>> +		BIO_free(b);
>> +	}
>> +
>> +	sig_size =3D BIO_number_written(bd) - loader_size;
>> +	sig_info.sig_len =3D htonl(sig_size);
>> +	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
>> +	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", d=
est_name);
>> +
>> +	ERR(BIO_free(bd) !=3D 1, "%s", dest_name);
>> +
>> +	/* Finally, if we're signing in place, replace the original. */
>> +	if (replace_orig)
>> +		ERR(rename(dest_name, loader_name) < 0, "%s", dest_name);
>> +
>> +	return 0;
>> +}
>> --=20
>> 2.48.1
>>=20
>
> BR, Jarkko

