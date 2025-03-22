Return-Path: <linux-kselftest+bounces-29612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C4AA6CBB1
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 18:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E0F7AD945
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 17:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72AD230270;
	Sat, 22 Mar 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHmXJoWX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873782E3384;
	Sat, 22 Mar 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742664427; cv=none; b=Mm3MFDWT9rVWShiUgpYleXxJjgqIj8u6Lsbrn8gASkEG3ZLGqQsnSZjr23mYA182KmZtKXi7oLZFZG8CwKW54iwGpRHLCZiokWFeegnt+SIg17w2Z+9bdBERZtLUKPCe91PisWBboeHK2q4LIyVSI/2OVx3ul1MxHfEczjr0V1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742664427; c=relaxed/simple;
	bh=Nfu6wNvCL+EzJpl6IHOf3pX6YzXpe81WwXFFqLz9FIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2fjWFaspgReuoS8OsSqTzCF1A7WJ77YlZgMhAEAjnVJ9j9dg7dv4ipe1d5QGUcoAZuJKyx5DbU6GqRZdnt4ImkIde0mBUhBTatQkLWjRA1eBGlq2j/yqjRH7Gz80A3Wf9FYgo/8yB9PniQWislfgWlOcxymYzPMvXd1IR7OVDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHmXJoWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 633ECC4CEDD;
	Sat, 22 Mar 2025 17:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742664426;
	bh=Nfu6wNvCL+EzJpl6IHOf3pX6YzXpe81WwXFFqLz9FIM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CHmXJoWXa14FCMnhmEJd056qw1hLG4PKWrMBDU6/T0xcmDywnvJwSntc+thdh6rgI
	 fFWZ14ay1leAC8ZW5kspPZ6C9BB4+7RidNw0KhZFZPYngqYn7IDI79VA9xhW+Vndnu
	 V8XU3rfLbcw9VNYgQalchwASQEJfquCxOWWdZN24GHo6ZDxl8TLpN4RrzKjK9HduLC
	 vRhwij99Rgwr5I6CO/NmVlWWWAsgdcZad2iSI0A9hIKboTmTxHXdTy4rVjT/se/5Qh
	 YT4pdZp/bdoUWu2/yxxRLXuaWQg8blGaLPeZNq7y9KJhUjVftqJlf2X+/MvxroD95t
	 KrDVNsbRAkpWg==
Date: Sat, 22 Mar 2025 19:27:03 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Shuah Khan <shuah@kernel.org>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Stancek <jstancek@redhat.com>, Neal Gompa <neal@gompa.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	llvm@lists.linux.dev, nkapron@google.com, teknoraver@meta.com,
	roberto.sassu@huawei.com, xiyou.wangcong@gmail.com
Subject: Re: [RFC PATCH security-next 2/4] hornet: Introduce sign-ebpf
Message-ID: <Z97y578XhzkTt0mK@kernel.org>
References: <20250321164537.16719-1-bboscaccy@linux.microsoft.com>
 <20250321164537.16719-3-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321164537.16719-3-bboscaccy@linux.microsoft.com>

On Fri, Mar 21, 2025 at 09:45:04AM -0700, Blaise Boscaccy wrote:
> This introduces the sign-ebpf tool. It is very similar to the existing
> sign-file script, with one key difference, it will sign a file with
> with a signature computed off of arbitrary input data. This can used
> to sign an ebpf light skeleton loader program for verification via
> hornet.
> 
> Typical usage is to provide a payload containing the lskel ebpf
> syscall program binary and it's associated maps, which can be
> extracted from the auto-generated skel header.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  scripts/Makefile           |   1 +
>  scripts/hornet/Makefile    |   5 +
>  scripts/hornet/sign-ebpf.c | 420 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 426 insertions(+)
>  create mode 100644 scripts/hornet/Makefile
>  create mode 100644 scripts/hornet/sign-ebpf.c
> 
> diff --git a/scripts/Makefile b/scripts/Makefile
> index 46f860529df5e..a2cace05d7342 100644
> --- a/scripts/Makefile
> +++ b/scripts/Makefile
> @@ -57,6 +57,7 @@ subdir-$(CONFIG_GENKSYMS) += genksyms
>  subdir-$(CONFIG_GENDWARFKSYMS) += gendwarfksyms
>  subdir-$(CONFIG_SECURITY_SELINUX) += selinux
>  subdir-$(CONFIG_SECURITY_IPE) += ipe
> +subdir-$(CONFIG_SECURITY_HORNET) += hornet
>  
>  # Let clean descend into subdirs
>  subdir-	+= basic dtc gdb kconfig mod
> diff --git a/scripts/hornet/Makefile b/scripts/hornet/Makefile
> new file mode 100644
> index 0000000000000..ab71dbb8688e4
> --- /dev/null
> +++ b/scripts/hornet/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +hostprogs-always-y	:= sign-ebpf
> +
> +HOSTCFLAGS_sign-ebpf.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
> +HOSTLDLIBS_sign-ebpf = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
> diff --git a/scripts/hornet/sign-ebpf.c b/scripts/hornet/sign-ebpf.c
> new file mode 100644
> index 0000000000000..ff98fddb79a15
> --- /dev/null
> +++ b/scripts/hornet/sign-ebpf.c
> @@ -0,0 +1,420 @@
> +/* Sign ebpf programs and skeletons using the given key.
> + *
> + * This program is heavily based on the kernel's sign-file tool
> + * with some minor additions to support the signing of eBPF lskels.
> + *
> + * Copyright © 2014-2016 Red Hat, Inc. All Rights Reserved.
> + * Copyright © 2015      Intel Corporation.
> + * Copyright © 2016      Hewlett Packard Enterprise Development LP
> + * Copyright © 2025      Microsoft Corporation.
> + *
> + * Authors: David Howells <dhowells@redhat.com>
> + *          David Woodhouse <dwmw2@infradead.org>
> + *          Juerg Haefliger <juerg.haefliger@hpe.com>
> + *          Blaise Boscaccy <bboscaccy@linux.microsoft.com>

I don't think that for new code ad-hoc authors lists in source code
make any sense.


> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public License
> + * as published by the Free Software Foundation; either version 2.1
> + * of the licence, or (at your option) any later version.

Redundant given SPDX.

> + */
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <err.h>
> +#include <arpa/inet.h>
> +#include <openssl/opensslv.h>
> +#include <openssl/bio.h>
> +#include <openssl/evp.h>
> +#include <openssl/pem.h>
> +#include <openssl/err.h>
> +#if OPENSSL_VERSION_MAJOR >= 3
> +# define USE_PKCS11_PROVIDER
> +# include <openssl/provider.h>
> +# include <openssl/store.h>
> +#else
> +# if !defined(OPENSSL_NO_ENGINE) && !defined(OPENSSL_NO_DEPRECATED_3_0)
> +#  define USE_PKCS11_ENGINE
> +#  include <openssl/engine.h>
> +# endif
> +#endif
> +#include "../ssl-common.h"
> +
> +/*
> + * Use CMS if we have openssl-1.0.0 or newer available - otherwise we have to
> + * assume that it's not available and its header file is missing and that we
> + * should use PKCS#7 instead.  Switching to the older PKCS#7 format restricts
> + * the options we have on specifying the X.509 certificate we want.
> + *
> + * Further, older versions of OpenSSL don't support manually adding signers to
> + * the PKCS#7 message so have to accept that we get a certificate included in
> + * the signature message.  Nor do such older versions of OpenSSL support
> + * signing with anything other than SHA1 - so we're stuck with that if such is
> + * the case.
> + */
> +#if defined(LIBRESSL_VERSION_NUMBER) || \
> +	OPENSSL_VERSION_NUMBER < 0x10000000L || \
> +	defined(OPENSSL_NO_CMS)
> +#define USE_PKCS7
> +#endif
> +#ifndef USE_PKCS7
> +#include <openssl/cms.h>
> +#else
> +#include <openssl/pkcs7.h>
> +#endif
> +
> +struct module_signature {
> +	uint8_t		algo;		/* Public-key crypto algorithm [0] */
> +	uint8_t		hash;		/* Digest algorithm [0] */
> +	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
> +	uint8_t		signer_len;	/* Length of signer's name [0] */
> +	uint8_t		key_id_len;	/* Length of key identifier [0] */
> +	uint8_t		__pad[3];
> +	uint32_t	sig_len;	/* Length of signature data */
> +};
> +
> +#define PKEY_ID_PKCS7 2
> +
> +static char magic_number[] = "~eBPF signature appended~\n";
> +
> +static __attribute__((noreturn))
> +void format(void)
> +{
> +	fprintf(stderr,
> +		"Usage: scripts/sign-ebpf [-dp] <hash algo> <key> <x509> <bin> <loader> [<dest>]\n");
> +	exit(2);
> +}
> +
> +static const char *key_pass;
> +
> +static int pem_pw_cb(char *buf, int len, int w, void *v)
> +{
> +	int pwlen;
> +
> +	if (!key_pass)
> +		return -1;
> +
> +	pwlen = strlen(key_pass);
> +	if (pwlen >= len)
> +		return -1;
> +
> +	strcpy(buf, key_pass);
> +
> +	/* If it's wrong, don't keep trying it. */
> +	key_pass = NULL;
> +
> +	return pwlen;
> +}
> +
> +static EVP_PKEY *read_private_key_pkcs11(const char *private_key_name)
> +{
> +	EVP_PKEY *private_key = NULL;
> +#ifdef USE_PKCS11_PROVIDER
> +	OSSL_STORE_CTX *store;
> +
> +	if (!OSSL_PROVIDER_try_load(NULL, "pkcs11", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(pkcs11)");
> +	if (!OSSL_PROVIDER_try_load(NULL, "default", true))
> +		ERR(1, "OSSL_PROVIDER_try_load(default)");
> +
> +	store = OSSL_STORE_open(private_key_name, NULL, NULL, NULL, NULL);
> +	ERR(!store, "OSSL_STORE_open");
> +
> +	while (!OSSL_STORE_eof(store)) {
> +		OSSL_STORE_INFO *info = OSSL_STORE_load(store);
> +
> +		if (!info) {
> +			drain_openssl_errors(__LINE__, 0);
> +			continue;
> +		}
> +		if (OSSL_STORE_INFO_get_type(info) == OSSL_STORE_INFO_PKEY) {
> +			private_key = OSSL_STORE_INFO_get1_PKEY(info);
> +			ERR(!private_key, "OSSL_STORE_INFO_get1_PKEY");
> +		}
> +		OSSL_STORE_INFO_free(info);
> +		if (private_key)
> +			break;
> +	}
> +	OSSL_STORE_close(store);
> +#elif defined(USE_PKCS11_ENGINE)
> +	ENGINE *e;
> +
> +	ENGINE_load_builtin_engines();
> +	drain_openssl_errors(__LINE__, 1);
> +	e = ENGINE_by_id("pkcs11");
> +	ERR(!e, "Load PKCS#11 ENGINE");
> +	if (ENGINE_init(e))
> +		drain_openssl_errors(__LINE__, 1);
> +	else
> +		ERR(1, "ENGINE_init");
> +	if (key_pass)
> +		ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0), "Set PKCS#11 PIN");
> +	private_key = ENGINE_load_private_key(e, private_key_name, NULL, NULL);
> +	ERR(!private_key, "%s", private_key_name);
> +#else
> +	fprintf(stderr, "no pkcs11 engine/provider available\n");
> +	exit(1);
> +#endif
> +	return private_key;
> +}
> +
> +static EVP_PKEY *read_private_key(const char *private_key_name)
> +{
> +	if (!strncmp(private_key_name, "pkcs11:", 7)) {
> +		return read_private_key_pkcs11(private_key_name);
> +	} else {
> +		EVP_PKEY *private_key;
> +		BIO *b;
> +
> +		b = BIO_new_file(private_key_name, "rb");
> +		ERR(!b, "%s", private_key_name);
> +		private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
> +						      NULL);
> +		ERR(!private_key, "%s", private_key_name);
> +		BIO_free(b);
> +
> +		return private_key;
> +	}
> +}
> +
> +static X509 *read_x509(const char *x509_name)
> +{
> +	unsigned char buf[2];
> +	X509 *x509;
> +	BIO *b;
> +	int n;
> +
> +	b = BIO_new_file(x509_name, "rb");
> +	ERR(!b, "%s", x509_name);
> +
> +	/* Look at the first two bytes of the file to determine the encoding */
> +	n = BIO_read(b, buf, 2);
> +	if (n != 2) {
> +		if (BIO_should_retry(b)) {
> +			fprintf(stderr, "%s: Read wanted retry\n", x509_name);
> +			exit(1);
> +		}
> +		if (n >= 0) {
> +			fprintf(stderr, "%s: Short read\n", x509_name);
> +			exit(1);
> +		}
> +		ERR(1, "%s", x509_name);
> +	}
> +
> +	ERR(BIO_reset(b) != 0, "%s", x509_name);
> +
> +	if (buf[0] == 0x30 && buf[1] >= 0x81 && buf[1] <= 0x84)
> +		/* Assume raw DER encoded X.509 */
> +		x509 = d2i_X509_bio(b, NULL);
> +	else
> +		/* Assume PEM encoded X.509 */
> +		x509 = PEM_read_bio_X509(b, NULL, NULL, NULL);
> +
> +	BIO_free(b);
> +	ERR(!x509, "%s", x509_name);
> +
> +	return x509;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
> +	char *hash_algo = NULL;
> +	char *private_key_name = NULL, *raw_sig_name = NULL;
> +	char *x509_name, *bin_name, *loader_name, *dest_name;
> +	bool save_sig = false, replace_orig;
> +	bool sign_only = false;
> +	bool raw_sig = false;
> +	unsigned char buf[4096];
> +	unsigned long loader_size, sig_size;
> +	unsigned int use_signed_attrs;
> +	const EVP_MD *digest_algo;
> +	EVP_PKEY *private_key;
> +#ifndef USE_PKCS7
> +	CMS_ContentInfo *cms = NULL;
> +	unsigned int use_keyid = 0;
> +#else
> +	PKCS7 *pkcs7 = NULL;
> +#endif
> +	X509 *x509;
> +	BIO *bd, *bm, *bl;
> +	int opt, n;
> +	OpenSSL_add_all_algorithms();
> +	ERR_load_crypto_strings();
> +	ERR_clear_error();
> +
> +	key_pass = getenv("KBUILD_SIGN_PIN");
> +
> +#ifndef USE_PKCS7
> +	use_signed_attrs = CMS_NOATTR;
> +#else
> +	use_signed_attrs = PKCS7_NOATTR;
> +#endif
> +
> +	do {
> +		opt = getopt(argc, argv, "sdpk");
> +		switch (opt) {
> +		case 's': raw_sig = true; break;
> +		case 'p': save_sig = true; break;
> +		case 'd': sign_only = true; save_sig = true; break;
> +#ifndef USE_PKCS7
> +		case 'k': use_keyid = CMS_USE_KEYID; break;
> +#endif
> +		case -1: break;
> +		default: format();
> +		}
> +	} while (opt != -1);
> +
> +	argc -= optind;
> +	argv += optind;
> +	if (argc < 5 || argc > 6)
> +		format();
> +
> +	if (raw_sig) {
> +		raw_sig_name = argv[0];
> +		hash_algo = argv[1];
> +	} else {
> +		hash_algo = argv[0];
> +		private_key_name = argv[1];
> +	}
> +	x509_name = argv[2];
> +	bin_name = argv[3];
> +	loader_name = argv[4];
> +	if (argc == 6 && strcmp(argv[4], argv[5]) != 0) {
> +		dest_name = argv[5];
> +		replace_orig = false;
> +	} else {
> +		ERR(asprintf(&dest_name, "%s.~signed~", loader_name) < 0,
> +		    "asprintf");
> +		replace_orig = true;
> +	}
> +
> +#ifdef USE_PKCS7
> +	if (strcmp(hash_algo, "sha1") != 0) {
> +		fprintf(stderr, "sign-file: %s only supports SHA1 signing\n",
> +			OPENSSL_VERSION_TEXT);
> +		exit(3);
> +	}
> +#endif
> +
> +	/* Open the bin file */
> +	bm = BIO_new_file(bin_name, "rb");
> +	ERR(!bm, "%s", bin_name);
> +
> +	if (!raw_sig) {
> +		/* Read the private key and the X.509 cert the PKCS#7 message
> +		 * will point to.
> +		 */
> +		private_key = read_private_key(private_key_name);
> +		x509 = read_x509(x509_name);
> +
> +		/* Digest the module data. */
> +		OpenSSL_add_all_digests();
> +		drain_openssl_errors(__LINE__, 0);
> +		digest_algo = EVP_get_digestbyname(hash_algo);
> +		ERR(!digest_algo, "EVP_get_digestbyname");
> +
> +#ifndef USE_PKCS7
> +		/* Load the signature message from the digest buffer. */
> +		cms = CMS_sign(NULL, NULL, NULL, NULL,
> +			       CMS_NOCERTS | CMS_PARTIAL | CMS_BINARY |
> +			       CMS_DETACHED | CMS_STREAM);
> +		ERR(!cms, "CMS_sign");
> +
> +		ERR(!CMS_add1_signer(cms, x509, private_key, digest_algo,
> +				     CMS_NOCERTS | CMS_BINARY |
> +				     CMS_NOSMIMECAP | use_keyid |
> +				     use_signed_attrs),
> +		    "CMS_add1_signer");
> +		ERR(CMS_final(cms, bm, NULL, CMS_NOCERTS | CMS_BINARY) != 1,
> +		    "CMS_final");
> +
> +#else
> +		pkcs7 = PKCS7_sign(x509, private_key, NULL, bm,
> +				   PKCS7_NOCERTS | PKCS7_BINARY |
> +				   PKCS7_DETACHED | use_signed_attrs);
> +		ERR(!pkcs7, "PKCS7_sign");
> +#endif
> +
> +		if (save_sig) {
> +			char *sig_file_name;
> +			BIO *b;
> +
> +			ERR(asprintf(&sig_file_name, "%s.p7s", bin_name) < 0,
> +			    "asprintf");
> +			b = BIO_new_file(sig_file_name, "wb");
> +			ERR(!b, "%s", sig_file_name);
> +#ifndef USE_PKCS7
> +			ERR(i2d_CMS_bio_stream(b, cms, NULL, 0) != 1,
> +			    "%s", sig_file_name);
> +#else
> +			ERR(i2d_PKCS7_bio(b, pkcs7) != 1,
> +			    "%s", sig_file_name);
> +#endif
> +			BIO_free(b);
> +		}
> +
> +		if (sign_only) {
> +			BIO_free(bm);
> +			return 0;
> +		}
> +	}
> +
> +	/* Open the destination file now so that we can shovel the loader data
> +	 * across as we read it.
> +	 */
> +	bd = BIO_new_file(dest_name, "wb");
> +	ERR(!bd, "%s", dest_name);
> +
> +	bl = BIO_new_file(loader_name, "rb");
> +	ERR(!bl, "%s", loader_name);
> +
> +
> +	/* Append the marker and the PKCS#7 message to the destination file */
> +	ERR(BIO_reset(bm) < 0, "%s", bin_name);
> +	ERR(BIO_reset(bl) < 0, "%s", loader_name);
> +	while ((n = BIO_read(bl, buf, sizeof(buf))),
> +	       n > 0) {
> +		ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
> +	}
> +	BIO_free(bl);
> +	BIO_free(bm);
> +	ERR(n < 0, "%s", loader_name);
> +	loader_size = BIO_number_written(bd);
> +
> +	if (!raw_sig) {
> +#ifndef USE_PKCS7
> +		ERR(i2d_CMS_bio_stream(bd, cms, NULL, 0) != 1, "%s", dest_name);
> +#else
> +		ERR(i2d_PKCS7_bio(bd, pkcs7) != 1, "%s", dest_name);
> +#endif
> +	} else {
> +		BIO *b;
> +
> +		/* Read the raw signature file and write the data to the
> +		 * destination file
> +		 */
> +		b = BIO_new_file(raw_sig_name, "rb");
> +		ERR(!b, "%s", raw_sig_name);
> +		while ((n = BIO_read(b, buf, sizeof(buf))), n > 0)
> +			ERR(BIO_write(bd, buf, n) < 0, "%s", dest_name);
> +		BIO_free(b);
> +	}
> +
> +	sig_size = BIO_number_written(bd) - loader_size;
> +	sig_info.sig_len = htonl(sig_size);
> +	ERR(BIO_write(bd, &sig_info, sizeof(sig_info)) < 0, "%s", dest_name);
> +	ERR(BIO_write(bd, magic_number, sizeof(magic_number) - 1) < 0, "%s", dest_name);
> +
> +	ERR(BIO_free(bd) != 1, "%s", dest_name);
> +
> +	/* Finally, if we're signing in place, replace the original. */
> +	if (replace_orig)
> +		ERR(rename(dest_name, loader_name) < 0, "%s", dest_name);
> +
> +	return 0;
> +}
> -- 
> 2.48.1
> 

BR, Jarkko

