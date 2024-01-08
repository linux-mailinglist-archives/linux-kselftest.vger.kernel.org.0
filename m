Return-Path: <linux-kselftest+bounces-2718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E182760E
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 18:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B28B1C21567
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jan 2024 17:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F654665;
	Mon,  8 Jan 2024 17:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OYb1jAD4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC8F54661
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Jan 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a277339dcf4so214031866b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 08 Jan 2024 09:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704734024; x=1705338824; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=72yIapf26W3MTkOxkgeYpNT24vmOx9hCDSp11cnRh3s=;
        b=OYb1jAD4fm4WbmGYD+hTMiaFLJfHqjWk0jy0NJbejKwfOui6rN7Qc/GbhdDYo8hCir
         8Yu5ygaUADiWDNqTiIExrtu5pzGD6+t+DdpJ0XZDEjW7JlQRuy8KHQH3W+zciFiWRjeT
         jYC1g18HnpBZ95uYoi+L4TUpKkpOMeRwynqhlAajxlxuWZvl3cHroRhyHdDIXB+Yor4/
         RiU3sAwG+ct8IFqCHEQYmZX0UiW8FavhNsjjB7B5gSIifVab/2x5LSJPkZ+gDfSQAXBG
         a3Bkek3ty2pLdo2KTTIGKc7/p6f0EJVd8clSLHxfEhByCd7Kh30hJ0RBwGQeSc7gSY6A
         SV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734024; x=1705338824;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72yIapf26W3MTkOxkgeYpNT24vmOx9hCDSp11cnRh3s=;
        b=H+qR07O7tZnqAcICv5Wu2BoOJTpcloSf1mLO3GO2WTCGoPvByj5rMloBfItGpdvZot
         ODhIBNXZLXgxiHSVjQipvaQ4N7evRTRo1ZCT9tA/CXjvaM/tkNbMCe36eKRv0jxWPahe
         q2h/h4lzQPaj6DrII+/AsVI7Mj8TWku3la0zOoJMIJnCd2Jg9foXlrQV61nFd1SP3IZ2
         +/tLbN4xRJhJJHgtnwF9pkgi27QgzGUhTTt5xpgGH8dEwWdKzyoRJ7oX+VMSSd0b9NOP
         3nWhYYrVLQTP7KZ9kU/zqT5duC8XcjBBSmByl1JvJ0EXijXwUhwxw9YEjhwlD9YMXM0h
         GMLg==
X-Gm-Message-State: AOJu0YwkYy7kYnXJrwSpxmyuE0F/2bU8V9Ht8yOr88+M+mLdakGsgc/u
	MmiqyBbOgUDfPMbKNARrMch42AhPnlPelw==
X-Google-Smtp-Source: AGHT+IH3cJA9S6q1KPJzco1BqKJ4kBMUC//wsZrUlu+DcpJtcQRDkqowbqPMEs8Y0NjueYWPNrObiQ==
X-Received: by 2002:a17:906:158f:b0:a23:482:ee74 with SMTP id k15-20020a170906158f00b00a230482ee74mr2177935ejd.28.1704734024389;
        Mon, 08 Jan 2024 09:13:44 -0800 (PST)
Received: from ?IPv6:2804:30c:1668:b300:8fcd:588d:fb77:ed04? ([2804:30c:1668:b300:8fcd:588d:fb77:ed04])
        by smtp.gmail.com with ESMTPSA id t7-20020a02ab87000000b00466754ca2fesm70249jan.68.2024.01.08.09.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:13:43 -0800 (PST)
Message-ID: <11c112df801008f6bc4b7813645d505388894e29.camel@suse.com>
Subject: Re: [PATCH RESEND v4 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR
 variable
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Joe Lawrence
	 <joe.lawrence@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Sven Schnelle <svens@linux.ibm.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,  Miroslav
 Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 live-patching@vger.kernel.org
Date: Mon, 08 Jan 2024 14:13:37 -0300
In-Reply-To: <4fb169fd-393c-441e-b0f7-32a3777c1d11@linuxfoundation.org>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
	 <20231220-send-lp-kselftests-v4-1-3458ec1b1a38@suse.com>
	 <ZZSOtsbzpy2mvmUC@redhat.com>
	 <4fb169fd-393c-441e-b0f7-32a3777c1d11@linuxfoundation.org>
Content-Type: multipart/mixed; boundary="=-Q9sYUJ/r34p0y6Es/xCH"
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-Q9sYUJ/r34p0y6Es/xCH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-01-03 at 15:09 -0700, Shuah Khan wrote:
> On 1/2/24 15:31, Joe Lawrence wrote:
> > On Wed, Dec 20, 2023 at 01:53:12PM -0300, Marcos Paulo de Souza
> > wrote:
> > > Add TEST_GEN_MODS_DIR variable for kselftests. It can point to
> > > a directory containing kernel modules that will be used by
> > > selftest scripts.
> > >=20
> > > The modules are built as external modules for the running kernel.
> > > As a result they are always binary compatible and the same tests
> > > can be used for older or newer kernels.
> > >=20
> > > The build requires "kernel-devel" package to be installed.
> > > For example, in the upstream sources, the rpm devel package
> > > is produced by "make rpm-pkg"
> > >=20
> > > The modules can be built independently by
> > >=20
> > > =C2=A0=C2=A0 make -C tools/testing/selftests/livepatch/
> > >=20
> > > or they will be automatically built before running the tests via
> > >=20
> > > =C2=A0=C2=A0 make -C tools/testing/selftests/livepatch/ run_tests
> > >=20
> > > Note that they are _not_ built when running the standalone
> > > tests by calling, for example, ./test-state.sh.
> > >=20
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > ---
> > > =C2=A0 Documentation/dev-tools/kselftest.rst |=C2=A0 4 ++++
> > > =C2=A0 tools/testing/selftests/lib.mk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 20 +++++++++++++++-----
> > > =C2=A0 2 files changed, 19 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/Documentation/dev-tools/kselftest.rst
> > > b/Documentation/dev-tools/kselftest.rst
> > > index ab376b316c36..7f3582a67318 100644
> > > --- a/Documentation/dev-tools/kselftest.rst
> > > +++ b/Documentation/dev-tools/kselftest.rst
> > > @@ -245,6 +245,10 @@ Contributing new tests (details)
> > > =C2=A0=C2=A0=C2=A0=C2=A0 TEST_PROGS, TEST_GEN_PROGS mean it is the ex=
ecutable tested
> > > by
> > > =C2=A0=C2=A0=C2=A0=C2=A0 default.
> > > =C2=A0=20
> > > +=C2=A0=C2=A0 TEST_GEN_MODS_DIR should be used by tests that require
> > > modules to be built
> > > +=C2=A0=C2=A0 before the test starts. The variable will contain the n=
ame of
> > > the directory
> > > +=C2=A0=C2=A0 containing the modules.
> > > +
> > > =C2=A0=C2=A0=C2=A0=C2=A0 TEST_CUSTOM_PROGS should be used by tests th=
at require
> > > custom build
> > > =C2=A0=C2=A0=C2=A0=C2=A0 rules and prevent common build rule use.
> > > =C2=A0=20
> > > diff --git a/tools/testing/selftests/lib.mk
> > > b/tools/testing/selftests/lib.mk
> > > index 118e0964bda9..6c7c5a0112cf 100644
> > > --- a/tools/testing/selftests/lib.mk
> > > +++ b/tools/testing/selftests/lib.mk
> > > @@ -70,12 +70,15 @@ KHDR_INCLUDES :=3D -isystem $(KHDR_DIR)
> > > =C2=A0 # TEST_PROGS are for test shell scripts.
> > > =C2=A0 # TEST_CUSTOM_PROGS and TEST_PROGS will be run by common
> > > run_tests
> > > =C2=A0 # and install targets. Common clean doesn't touch them.
> > > +# TEST_GEN_MODS_DIR is used to specify a directory with modules
> > > to be built
> > > +# before the test executes. These modules are cleaned on the
> > > clean target as well.
> > > =C2=A0 TEST_GEN_PROGS :=3D $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS)=
)
> > > =C2=A0 TEST_GEN_PROGS_EXTENDED :=3D $(patsubst
> > > %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
> > > =C2=A0 TEST_GEN_FILES :=3D $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES)=
)
> > > +TEST_GEN_MODS_DIR :=3D $(patsubst
> > > %,$(OUTPUT)/%,$(TEST_GEN_MODS_DIR))
> > > =C2=A0=20
> > > =C2=A0 all: kernel_header_files $(TEST_GEN_PROGS)
> > > $(TEST_GEN_PROGS_EXTENDED) \
> > > -=C2=A0=C2=A0=C2=A0=C2=A0 $(TEST_GEN_FILES)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 $(TEST_GEN_FILES) $(if $(TEST_GEN_MODS_DIR)=
,gen_mods_dir)
> > > =C2=A0=20
> > > =C2=A0 kernel_header_files:
> > > =C2=A0=C2=A0	@ls $(KHDR_DIR)/linux/*.h >/dev/null
> > > 2>/dev/null;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
> > > @@ -105,8 +108,8 @@ endef
> > > =C2=A0=20
> > > =C2=A0 run_tests: all
> > > =C2=A0 ifdef building_out_of_srctree
> > > -	@if [
> > > "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" !=3D "X" ];
> > > then \
> > > -		rsync -aq --copy-unsafe-links $(TEST_PROGS)
> > > $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
> > > +	@if [
> > > "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)$(TEST_GEN_MODS
> > > _DIR)" !=3D "X" ]; then \
> > > +		rsync -aq --copy-unsafe-links $(TEST_PROGS)
> > > $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(TEST_GEN_MODS_DIR)
> > > $(OUTPUT); \
> > > =C2=A0=C2=A0	fi
> > > =C2=A0=C2=A0	@if [ "X$(TEST_PROGS)" !=3D "X" ]; then \
> > > =C2=A0=C2=A0		$(call RUN_TESTS, $(TEST_GEN_PROGS)
> > > $(TEST_CUSTOM_PROGS) \
> > > @@ -118,6 +121,12 @@ else
> > > =C2=A0=C2=A0	@$(call RUN_TESTS, $(TEST_GEN_PROGS)
> > > $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
> > > =C2=A0 endif
> > > =C2=A0=20
> > > +gen_mods_dir:
> > > +	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR)
> > > +
> > > +clean_mods_dir:
> > > +	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean
> > > +
> > > =C2=A0 define INSTALL_SINGLE_RULE
> > > =C2=A0=C2=A0	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
> > > =C2=A0=C2=A0	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links
> > > $(INSTALL_LIST) $(INSTALL_PATH)/)
> > > @@ -131,6 +140,7 @@ define INSTALL_RULE
> > > =C2=A0=C2=A0	$(eval INSTALL_LIST =3D $(TEST_CUSTOM_PROGS))
> > > $(INSTALL_SINGLE_RULE)
> > > =C2=A0=C2=A0	$(eval INSTALL_LIST =3D $(TEST_GEN_PROGS_EXTENDED))
> > > $(INSTALL_SINGLE_RULE)
> > > =C2=A0=C2=A0	$(eval INSTALL_LIST =3D $(TEST_GEN_FILES))
> > > $(INSTALL_SINGLE_RULE)
> > > +	$(eval INSTALL_LIST =3D $(TEST_GEN_MODS_DIR))
> > > $(INSTALL_SINGLE_RULE)
> >=20
> > Hi Marcos,
> >=20
> > Sorry for the late reply on this, but I'm reviewing this version by
> > trying to retrofit it into our selftest packaging (pre-build the
> > test
> > module .ko's and stash those into an rpm rather than building on
> > the
> > test host).
> >=20
> > Since $TEST_GEN_MODS_DIR is treated as a directory, I found that
> > the
> > selftest install target copies a bunch of intermediate object and
> > kbuild
> > files:
> >=20
> > =C2=A0=C2=A0 $ mkdir /tmp/test-install
> > =C2=A0=C2=A0 $ make KDIR=3D$(pwd) INSTALL_PATH=3D/tmp/test-install
> > TARGETS=3Dlivepatch \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -C tools/testing/selftests/ =
install
> >=20
> > =C2=A0=C2=A0 [ ... builds livepatch selftests ... ]
> >=20
> > the rsync in question:
> >=20
> > =C2=A0=C2=A0 rsync -a --copy-unsafe-links
> > /home/jolawren/src/kernel/tools/testing/selftests/livepatch/test_mo
> > dules /tmp/test-install/livepatch/
> > =C2=A0=C2=A0 ...
> >=20
> > and then looking at the destination:
> >=20
> > =C2=A0=C2=A0 $ tree -a /tmp/test-install/
> > =C2=A0=C2=A0 /tmp/test-install/
> > =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kselftest
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 module.s=
h
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 prefix.p=
l
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 runner.s=
h
> > =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 kselftest-list.txt
> > =C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 livepatch
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 config
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 function=
s.sh
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 settings
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 test-cal=
lbacks.sh
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 test-ftr=
ace.sh
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 test_klp=
-call_getpid
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 test-liv=
epatch.sh
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 test_mod=
ules
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 Makefile
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 modules.order
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 .modules.order.cmd
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 Module.symvers
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 .Module.symvers.cmd
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 test_klp_atomic_replace.c
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 test_klp_atomic_replace.ko
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 .test_klp_atomic_replace.ko.cmd
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 test_klp_atomic_replace.mod
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 test_klp_atomic_replace.mod.c
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 .test_klp_atomic_replace.mod.cmd
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 test_klp_atomic_replace.mod.o
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 .test_klp_atomic_replace.mod.o.cmd
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 test_klp_atomic_replace.o
> > =C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=
=94=80=E2=94=80 .test_klp_atomic_replace.o.cmd
> > =C2=A0=C2=A0 ...
> >=20
> > On the other hand, variables like $TEST_GEN_FILES specify
> > individual
> > files, so only final binaries like test_klp-call_getpid (and not
> > test_klp-call_getpid.c) are copied to $INSTALL_PATH.

Hi Joe,

thanks for catching this issue. I crafted the attached patch and it
fixes the issue for me, copying only the resulting .ko objects as
expected. Can you please check if this fixes the issue for you?

>=20
>=20
> Thank you Joe for finding this problem.
>=20
> Copying source files and object files doesn't sound right. This isn't
> how the ksleftest installs work. Let's fix this.

Hi Shuah,

what do you think about the proposed solution? Could you please amend
the fix into the first patch if you think it's the right approach?

Thanks in advance!
  Marcos

>=20
> thanks,
> --Shuah
>=20


--=-Q9sYUJ/r34p0y6Es/xCH
Content-Type: text/x-patch; name="fix.patch"; charset="UTF-8"
Content-Description: 
Content-Disposition: inline; filename="fix.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xpYi5tayBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2xpYi5tawppbmRleCA2YzdjNWEwMTEyY2YuLmQ3N2RkYTU5ZjZhMiAxMDA2
NDQKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbGliLm1rCisrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2xpYi5tawpAQCAtMTMyLDYgKzEzMiwxMSBAQCBkZWZpbmUgSU5TVEFMTF9T
SU5HTEVfUlVMRQogCSQoaWYgJChJTlNUQUxMX0xJU1QpLHJzeW5jIC1hIC0tY29weS11bnNhZmUt
bGlua3MgJChJTlNUQUxMX0xJU1QpICQoSU5TVEFMTF9QQVRIKS8pCiBlbmRlZgogCitkZWZpbmUg
SU5TVEFMTF9NT0RTX1JVTEUKKwkkKGlmICQoSU5TVEFMTF9MSVNUKSxAbWtkaXIgLXAgJChJTlNU
QUxMX1BBVEgpLyQoSU5TVEFMTF9MSVNUKSkKKwkkKGlmICQoSU5TVEFMTF9MSVNUKSxyc3luYyAt
YSAtLWNvcHktdW5zYWZlLWxpbmtzICQoSU5TVEFMTF9MSVNUKS8qLmtvICQoSU5TVEFMTF9QQVRI
KS8kKElOU1RBTExfTElTVCkpCitlbmRlZgorCiBkZWZpbmUgSU5TVEFMTF9SVUxFCiAJJChldmFs
IElOU1RBTExfTElTVCA9ICQoVEVTVF9QUk9HUykpICQoSU5TVEFMTF9TSU5HTEVfUlVMRSkKIAkk
KGV2YWwgSU5TVEFMTF9MSVNUID0gJChURVNUX1BST0dTX0VYVEVOREVEKSkgJChJTlNUQUxMX1NJ
TkdMRV9SVUxFKQpAQCAtMTQwLDcgKzE0NSw3IEBAIGRlZmluZSBJTlNUQUxMX1JVTEUKIAkkKGV2
YWwgSU5TVEFMTF9MSVNUID0gJChURVNUX0NVU1RPTV9QUk9HUykpICQoSU5TVEFMTF9TSU5HTEVf
UlVMRSkKIAkkKGV2YWwgSU5TVEFMTF9MSVNUID0gJChURVNUX0dFTl9QUk9HU19FWFRFTkRFRCkp
ICQoSU5TVEFMTF9TSU5HTEVfUlVMRSkKIAkkKGV2YWwgSU5TVEFMTF9MSVNUID0gJChURVNUX0dF
Tl9GSUxFUykpICQoSU5TVEFMTF9TSU5HTEVfUlVMRSkKLQkkKGV2YWwgSU5TVEFMTF9MSVNUID0g
JChURVNUX0dFTl9NT0RTX0RJUikpICQoSU5TVEFMTF9TSU5HTEVfUlVMRSkKKwkkKGV2YWwgSU5T
VEFMTF9MSVNUID0gJChub3RkaXIgJChURVNUX0dFTl9NT0RTX0RJUikpKSAkKElOU1RBTExfTU9E
U19SVUxFKQogCSQoZXZhbCBJTlNUQUxMX0xJU1QgPSAkKHdpbGRjYXJkIGNvbmZpZyBzZXR0aW5n
cykpICQoSU5TVEFMTF9TSU5HTEVfUlVMRSkKIGVuZGVmCiAK


--=-Q9sYUJ/r34p0y6Es/xCH--

