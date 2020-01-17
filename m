Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8708E1406D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgAQJtn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 04:49:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgAQJtn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 04:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579254581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2DEmJ5gzdkN5fJt0y4FiCUVkAhDydkqj1OLIvLy08AQ=;
        b=RCMWlkyQQTr6LREvoO7lxdinD+7N/Rgo5XeDO3LaKgx6g9poxHJ189ocRv5dr2bQHKsRx3
        lkAoxLGfIpcj8ikVmtgM9S2BbPTHNP6lgSqNmioWXrNYnWbRU5vyzXgG77YY8hC7+aKd+Y
        QQlGbV9+NWeVyqo6KS1kXOm/WLRMKBg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-kjTX9C6vP-SygaWnMIm2vA-1; Fri, 17 Jan 2020 04:49:40 -0500
X-MC-Unique: kjTX9C6vP-SygaWnMIm2vA-1
Received: by mail-lf1-f70.google.com with SMTP id c16so4230880lfm.10
        for <linux-kselftest@vger.kernel.org>; Fri, 17 Jan 2020 01:49:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2DEmJ5gzdkN5fJt0y4FiCUVkAhDydkqj1OLIvLy08AQ=;
        b=o1TOJ7dcd1xgySm+Fr5y8BPMtF9J2IQEUxDETPhvAZlsv9YvKnSCS/e60g7ltmtbBX
         gWw2/db5+jrYqHGrSOW/oukbo+M7f9c6Ai2lhgzLLyJ6ugtZtUsOHKkZ4vWY0sPcMyRR
         9TtJYlOo1x/6LMYP5odb/zipxC6S4Fn/7RwFlBWsSaK7/onol9apsT6R9AQmU7q6yrf7
         xs0g0PTmDCn/pbgCXpnGDpwhECmmd+Vuox75dJ/Ix0XfCWq8YcncK5neO4XuqnmXxmFc
         prSCGVt1BWssuV3/oDmISdsLZL47fsGsItI8KqOMxtvpE8z0DSWPjch13DbFSw+ksOpe
         JRTA==
X-Gm-Message-State: APjAAAW4dtA66Uv7EP/Wspgrl7y355zNKmTRj6TAxlNFZ5vrME5tTSMF
        IHo5Pdd+QvyVAaKYDfe5dMCen39u4+F5atG+DT3X86o/zTXpohQ939JTv76fmPSsSxfMykR2d6d
        j+Q7qkUbjc5Gncn/BjRDpRTWth1gQ
X-Received: by 2002:a2e:5357:: with SMTP id t23mr5182989ljd.227.1579254578951;
        Fri, 17 Jan 2020 01:49:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyk8gykyxX78t+pO2Au2DCESKKccxpSnivLcv8OMT8l6K8LCcsYcPg8bPfRFnts07+nJ1KN3Q==
X-Received: by 2002:a2e:5357:: with SMTP id t23mr5182947ljd.227.1579254578524;
        Fri, 17 Jan 2020 01:49:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r9sm13683623lfc.72.2020.01.17.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:49:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C6AC21804D6; Fri, 17 Jan 2020 10:49:36 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-rdma@vger.kernel.org,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH bpf-next v3 09/11] selftests: Remove tools/lib/bpf from include path
In-Reply-To: <CAEf4Bzba5FHN_iN52qRiGisRcauur1FqDY545EwE+RVR-nFvQA@mail.gmail.com>
References: <157918093154.1357254.7616059374996162336.stgit@toke.dk> <157918094179.1357254.14428494370073273452.stgit@toke.dk> <CAEf4Bzba5FHN_iN52qRiGisRcauur1FqDY545EwE+RVR-nFvQA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 17 Jan 2020 10:49:36 +0100
Message-ID: <87r1zyquof.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Thu, Jan 16, 2020 at 5:28 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> To make sure no new files are introduced that doesn't include the bpf/
>> prefix in its #include, remove tools/lib/bpf from the include path
>> entirely.
>>
>> Instead, we introduce a new header files directory under the scratch too=
ls/
>> dir, and add a rule to run the 'install_headers' rule from libbpf to hav=
e a
>> full set of consistent libbpf headers in $(OUTPUT)/tools/include/bpf, and
>> then use $(OUTPUT)/tools/include as the include path for selftests.
>>
>> For consistency we also make sure we put all the scratch build files from
>> other bpftool and libbpf into tools/build/, so everything stays within
>> selftests/.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>>  tools/testing/selftests/bpf/.gitignore |    1 +
>>  tools/testing/selftests/bpf/Makefile   |   50 +++++++++++++++++++------=
-------
>>  2 files changed, 31 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/self=
tests/bpf/.gitignore
>> index 1d14e3ab70be..849be9990ad2 100644
>> --- a/tools/testing/selftests/bpf/.gitignore
>> +++ b/tools/testing/selftests/bpf/.gitignore
>> @@ -40,3 +40,4 @@ test_cpp
>>  /bpf_gcc
>>  /tools
>>  bpf_helper_defs.h
>> +/include/bpf
>
> Isn't the real path (within selftests/bpf) a tools/include/bpf, which
> is already ignored through /tools rule?

Yeah, you're correct. I started out with having it in include/bpf, but
ended up moving it, and guess I forgot to remove the .gitignore. Will fix.

>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selfte=
sts/bpf/Makefile
>> index 1fd7da49bd56..c3fa695bb028 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -20,8 +20,8 @@ CLANG         ?=3D clang
>>  LLC            ?=3D llc
>>  LLVM_OBJCOPY   ?=3D llvm-objcopy
>>  BPF_GCC                ?=3D $(shell command -v bpf-gcc;)
>> -CFLAGS +=3D -g -Wall -O2 $(GENFLAGS) -I$(CURDIR) -I$(APIDIR) -I$(LIBDIR=
)  \
>> -         -I$(BPFDIR) -I$(GENDIR) -I$(TOOLSINCDIR)                      \
>> +CFLAGS +=3D -g -Wall -O2 $(GENFLAGS) -I$(CURDIR) -I$(APIDIR)           =
   \
>> +         -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR) -I$(TOOLSINCDIR)     \
>>           -Dbpf_prog_load=3Dbpf_prog_test_load                          =
  \
>>           -Dbpf_load_program=3Dbpf_test_load_program
>>  LDLIBS +=3D -lcap -lelf -lz -lrt -lpthread
>> @@ -97,11 +97,15 @@ OVERRIDE_TARGETS :=3D 1
>>  override define CLEAN
>>         $(call msg,CLEAN)
>>         $(RM) -r $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN=
_FILES) $(EXTRA_CLEAN)
>> -       $(MAKE) -C $(BPFDIR) OUTPUT=3D$(OUTPUT)/ clean
>>  endef
>>
>>  include ../lib.mk
>>
>> +SCRATCH_DIR :=3D $(OUTPUT)/tools
>> +BUILD_DIR :=3D $(SCRATCH_DIR)/build
>> +INCLUDE_DIR :=3D $(SCRATCH_DIR)/include
>> +INCLUDE_BPF :=3D $(INCLUDE_DIR)/bpf/bpf.h
>> +
>>  # Define simple and short `make test_progs`, `make test_sysctl`, etc ta=
rgets
>>  # to build individual tests.
>>  # NOTE: Semicolon at the end is critical to override lib.mk's default s=
tatic
>> @@ -120,7 +124,7 @@ $(OUTPUT)/urandom_read: urandom_read.c
>>         $(call msg,BINARY,,$@)
>>         $(CC) -o $@ $< -Wl,--build-id
>>
>> -$(OUTPUT)/test_stub.o: test_stub.c
>> +$(OUTPUT)/test_stub.o: test_stub.c $(INCLUDE_BPF)
>>         $(call msg,CC,,$@)
>>         $(CC) -c $(CFLAGS) -o $@ $<
>>
>> @@ -129,7 +133,7 @@ $(OUTPUT)/runqslower: force
>>         $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower     =
      \
>>                     OUTPUT=3D$(CURDIR)/tools/ VMLINUX_BTF=3D$(abspath ..=
/../../../vmlinux)
>>
>> -BPFOBJ :=3D $(OUTPUT)/libbpf.a
>> +BPFOBJ :=3D $(BUILD_DIR)/libbpf/libbpf.a
>>
>>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(OUTPUT)/test_stub.o $(B=
PFOBJ)
>>
>> @@ -155,17 +159,23 @@ force:
>>  DEFAULT_BPFTOOL :=3D $(OUTPUT)/tools/sbin/bpftool
>>  BPFTOOL ?=3D $(DEFAULT_BPFTOOL)
>>
>> -$(DEFAULT_BPFTOOL): force
>> -       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                 =
      \
>> +$(BUILD_DIR)/libbpf $(BUILD_DIR)/bpftool $(INCLUDE_DIR):
>> +       $(call msg,MKDIR,,$@)
>> +       mkdir -p $@
>> +
>> +$(DEFAULT_BPFTOOL): force $(BUILD_DIR)/bpftool
>
> directories should be included as order-only dependencies (after | )

OK.

>> +       $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)         \
>> +                   OUTPUT=3D$(BUILD_DIR)/bpftool/                      =
  \
>>                     prefix=3D DESTDIR=3D$(OUTPUT)/tools/ install
>>
>> -$(BPFOBJ): force
>> -       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=3D$(OUTPUT)/
>> +$(BPFOBJ): force $(BUILD_DIR)/libbpf
>
> same
>
>> +       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) \
>> +               OUTPUT=3D$(BUILD_DIR)/libbpf/
>>
>> -BPF_HELPERS :=3D $(OUTPUT)/bpf_helper_defs.h $(wildcard $(BPFDIR)/bpf_*=
.h)
>> -$(OUTPUT)/bpf_helper_defs.h: $(BPFOBJ)
>> -       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                      =
      \
>> -                   OUTPUT=3D$(OUTPUT)/ $(OUTPUT)/bpf_helper_defs.h
>> +BPF_HELPERS :=3D $(wildcard $(BPFDIR)/bpf_*.h) $(INCLUDE_BPF)
>
> Shouldn't all BPF_HELPERS come from $(INCLUDE_DIR)/bpf now?
>
>> +$(INCLUDE_BPF): force $(BPFOBJ)
>
> And this can be more properly a $(BPF_HELPERS): force $(BPFOBJ)?
>
>> +       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) install_headers \
>> +               OUTPUT=3D$(BUILD_DIR)/libbpf/ DESTDIR=3D$(SCRATCH_DIR) p=
refix=3D
>>
>>  # Get Clang's default includes on this system, as opposed to those seen=
 by
>>  # '-target bpf'. This fixes "missing" files on some architectures/distr=
os,
>> @@ -185,8 +195,8 @@ MENDIAN=3D$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-=
mbig-endian)
>>
>>  CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG))
>>  BPF_CFLAGS =3D -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)                =
  \
>> -            -I$(OUTPUT) -I$(CURDIR) -I$(CURDIR)/include/uapi           \
>> -            -I$(APIDIR) -I$(LIBDIR) -I$(BPFDIR) -I$(abspath $(OUTPUT)/.=
./usr/include)
>> +            -I$(INCLUDE_DIR) -I$(CURDIR) -I$(CURDIR)/include/uapi      \
>> +            -I$(APIDIR) -I$(abspath $(OUTPUT)/../usr/include)
>>
>>  CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES) \
>>                -Wno-compare-distinct-pointer-types
>> @@ -306,7 +316,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:   =
                \
>>                       $(TRUNNER_EXTRA_HDRS)                             \
>>                       $(TRUNNER_BPF_OBJS)                               \
>>                       $(TRUNNER_BPF_SKELS)                              \
>> -                     $$(BPFOBJ) | $(TRUNNER_OUTPUT)
>> +                     $$(BPFOBJ) $$(INCLUDE_BPF) | $(TRUNNER_OUTPUT)
>
> singling out $(INCLUDE_BPF) looks weird? But I think $(BPFOBJ)
> achieves the same effect, so this change can be probably dropped? Same
> below.

I was having some trouble getting the dependency order right here.
$(INCLUDE_BPF) depends on $(BPFOBJ), not the other way around. May be
fixable though, I'll take another look.

-Toke

