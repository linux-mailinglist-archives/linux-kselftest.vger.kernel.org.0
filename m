Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF096F3C82
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 06:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEBEDC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 00:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjEBEDB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 00:03:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6FC172E;
        Mon,  1 May 2023 21:02:58 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9505214c47fso662534266b.1;
        Mon, 01 May 2023 21:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683000177; x=1685592177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZQ99yFigo7RP4vUqSoJAW3rFQ5koBxMnAL7Mg6H1Go=;
        b=dzLkR/vN0o99nOrjWVyYBjVpZuAHBnTfdobKPwCFv3C4ZpLjfSteN68XOM5k7GLaUB
         D5dN33mWqwGHeSzl+Tzokh8UOSsSh7eRfhdCGGWZT7Y/lXTsKkW0pjKztN42E8F0QzLy
         21m6hma8M5dAhMR2GRRg0WNH2X7LdaJuFaFLb4x0urbsv2ObHIdrsA+yb34Kjsfmdla9
         VnjO7eiOiCanudXCkAYzu1ZeGA7jcSLI8Ns3z1CwQLcHEi8cJn1cgMDO4b3QtEKwBuQ3
         9jLmH/eHkIKGKsK45uZkSsu40EB3uDF9sKKHou99Czx9SaQOnrs3sp7kuw8c8Xr6s+MW
         Hn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683000177; x=1685592177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZQ99yFigo7RP4vUqSoJAW3rFQ5koBxMnAL7Mg6H1Go=;
        b=B7UPYSTmRSBXXOzyD5UjAxvXGwpXNcXsMt6VA/dH1hrWS5HdcoPZejHiYxXr444Veu
         y8YFXjfJJmCkk8eWdMQpPOrRNCw4ZWCSgccjRif8vLavAfjKh5oGfKYI+gY2fFA2jLLi
         ebQNRa+eDec1mobFl+W/7ojGEt54HWNsDZjggtaRyJ9COCKHMC0YaOu2VVl3338uqX12
         OhRROxMYkzqVk1iFaYW1v8Te7AES75dbHo+YOJS9AVGKe64rUvaf+8iiAnQu3ot7kQsU
         hMXyrIP33x2d8c4rl2vSrYfAM2enaFUhQXByhI4Rcb9V1T+b5wY/5l+Mn9QNoPRUV2XF
         LMkA==
X-Gm-Message-State: AC+VfDwoGmREOitpbiNW2lOAJpqONn92LBP4V8xri/HCiUoRPkouy4yN
        vmc62eMyJBjI+dyWwB3Gupaj6LsD/YUYepsOE5c=
X-Google-Smtp-Source: ACHHUZ5ksb9Cbi7KXDE+COpjHvOA8zH8lTLLPVzsoqV6yRd5bHgOleof/BJ4C3yskxaNZ4NLou/l7pkyqG1HRZEjlCU=
X-Received: by 2002:a17:907:1689:b0:94f:2d38:896b with SMTP id
 hc9-20020a170907168900b0094f2d38896bmr18507647ejc.53.1683000176934; Mon, 01
 May 2023 21:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <ZEV/EzOM+TJomP66@eg>
In-Reply-To: <ZEV/EzOM+TJomP66@eg>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 1 May 2023 21:02:44 -0700
Message-ID: <CAEf4BzZTrjjyyOm3ak9JsssPSh6T_ZmGd677a2rt5e5rBLUrpQ@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Improve version handling when attaching uprobe
To:     Espen Grindhaug <espen.grindhaug@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Apr 23, 2023 at 11:55=E2=80=AFAM Espen Grindhaug
<espen.grindhaug@gmail.com> wrote:
>
> This change fixes the handling of versions in elf_find_func_offset.
> In the previous implementation, we incorrectly assumed that the
> version information would be present in the string found in the
> string table.
>
> We now look up the correct version string in the version symbol
> table before constructing the full name and then comparing.
>
> This patch adds support for both name@version and name@@version to
> match output of the various elf parsers.
>
> Signed-off-by: Espen Grindhaug <espen.grindhaug@gmail.com>
> ---
> Changes since v1:
> - Added test
> ---
>  tools/lib/bpf/libbpf.c                        | 148 +++++++++++++++---
>  .../selftests/bpf/prog_tests/attach_probe.c   |  37 +++++
>  .../selftests/bpf/progs/test_attach_probe.c   |  15 ++
>  3 files changed, 181 insertions(+), 19 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 49cd304ae3bc..ef5e11ce6241 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10620,31 +10620,94 @@ static int perf_event_uprobe_open_legacy(const =
char *probe_name, bool retprobe,
>  }
>
>  /* Return next ELF section of sh_type after scn, or first of that type i=
f scn is NULL. */
> -static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn=
 *scn)
> +static Elf_Scn *elf_find_next_scn_by_type(Elf *elf, int sh_type, Elf_Scn=
 *scn, size_t *idx)
>  {
>         while ((scn =3D elf_nextscn(elf, scn)) !=3D NULL) {
>                 GElf_Shdr sh;
>
>                 if (!gelf_getshdr(scn, &sh))
>                         continue;
> -               if (sh.sh_type =3D=3D sh_type)
> +               if (sh.sh_type =3D=3D sh_type) {
> +                       if (idx)
> +                               *idx =3D sh.sh_link;
>                         return scn;
> +               }
> +       }
> +       return NULL;
> +}
> +
> +static Elf_Data *elf_find_data_by_type(Elf *elf, int sh_type, size_t *id=
x)
> +{
> +       Elf_Scn *scn =3D elf_find_next_scn_by_type(elf, sh_type, NULL, id=
x);
> +
> +       if (scn)
> +               return elf_getdata(scn, NULL);
> +
> +       return NULL;
> +}
> +
> +static Elf64_Verdef *elf_verdef_by_offset(Elf_Data *data, size_t offset)
> +{
> +       if (offset + sizeof(Elf64_Verdef) > data->d_size)
> +               return NULL;
> +
> +       return (Elf64_Verdef *)((char *) data->d_buf + offset);
> +}
> +
> +static Elf64_Versym *elf_versym_by_idx(Elf_Data *data, size_t idx)
> +{
> +       if (idx >=3D data->d_size / sizeof(Elf64_Versym))
> +               return NULL;
> +
> +       return (Elf64_Versym *)(data->d_buf + idx * sizeof(Elf64_Versym))=
;
> +}
> +
> +static Elf64_Verdaux *elf_verdaux_by_offset(Elf_Data *data, size_t offse=
t)
> +{
> +       if (offset + sizeof(Elf64_Verdaux) > data->d_size)
> +               return NULL;
> +
> +       return (Elf64_Verdaux *)((char *) data->d_buf + offset);
> +}
> +
> +#define ELF_VERSYM_HIDDEN 0x8000
> +#define ELF_VERSYM_IDX_MASK 0x7fff
> +
> +static Elf64_Verdaux *elf_get_verdaux_by_versym(Elf_Data *verdef_data, E=
lf64_Versym *versym)
> +{
> +       size_t offset =3D 0;
> +
> +       while (offset + sizeof(Elf64_Verdef) <=3D verdef_data->d_size) {
> +               Elf64_Verdef *verdef =3D elf_verdef_by_offset(verdef_data=
, offset);
> +
> +               if (!verdef)
> +                       break;
> +
> +               if (verdef->vd_ndx =3D=3D (*versym & ELF_VERSYM_IDX_MASK)=
)
> +                       return elf_verdaux_by_offset(verdef_data, offset =
+ verdef->vd_aux);
> +
> +               if (verdef->vd_next =3D=3D 0)
> +                       break;
> +
> +               offset +=3D verdef->vd_next;
>         }
>         return NULL;
>  }

So all of the above is quite cryptic and unclear. I, for example,
don't really know how symbol versioning information is laid out in
ELF, and it's very hard to follow the logic here. Please add comments
explaining the format and how different sections are related to each
other.

>
>  /* Find offset of function name in the provided ELF object. "binary_path=
" is
>   * the path to the ELF binary represented by "elf", and only used for er=
ror
> - * reporting matters. "name" matches symbol name or name@@LIB for librar=
y
> - * functions.
> + * reporting matters. "name" matches symbol name, name@LIB or name@@LIB =
for
> + * library functions.
>   */
>  static long elf_find_func_offset(Elf *elf, const char *binary_path, cons=
t char *name)
>  {
>         int i, sh_types[2] =3D { SHT_DYNSYM, SHT_SYMTAB };
>         bool is_shared_lib, is_name_qualified;
>         long ret =3D -ENOENT;
> -       size_t name_len;
>         GElf_Ehdr ehdr;
> +       Elf_Data *versym_data =3D NULL;
> +       Elf_Data *verdef_data =3D NULL;
> +       size_t verdef_stridx =3D 0;
>
>         if (!gelf_getehdr(elf, &ehdr)) {
>                 pr_warn("elf: failed to get ehdr from %s: %s\n", binary_p=
ath, elf_errmsg(-1));
> @@ -10654,9 +10717,12 @@ static long elf_find_func_offset(Elf *elf, const=
 char *binary_path, const char *
>         /* for shared lib case, we do not need to calculate relative offs=
et */
>         is_shared_lib =3D ehdr.e_type =3D=3D ET_DYN;
>
> -       name_len =3D strlen(name);
> -       /* Does name specify "@@LIB"? */
> -       is_name_qualified =3D strstr(name, "@@") !=3D NULL;
> +       /* Does name specify "@@LIB" or "@LIB"? */
> +       is_name_qualified =3D strstr(name, "@") !=3D NULL;
> +
> +       /* Extract version definition and version symbol table */
> +       versym_data =3D elf_find_data_by_type(elf, SHT_GNU_versym, NULL);
> +       verdef_data =3D elf_find_data_by_type(elf, SHT_GNU_verdef, &verde=
f_stridx);
>
>         /* Search SHT_DYNSYM, SHT_SYMTAB for symbol. This search order is=
 used because if
>          * a binary is stripped, it may only have SHT_DYNSYM, and a fully=
-statically
> @@ -10671,10 +10737,10 @@ static long elf_find_func_offset(Elf *elf, cons=
t char *binary_path, const char *
>                 const char *sname;
>                 GElf_Shdr sh;
>
> -               scn =3D elf_find_next_scn_by_type(elf, sh_types[i], NULL)=
;
> +               scn =3D elf_find_next_scn_by_type(elf, sh_types[i], NULL,=
 NULL);
>                 if (!scn) {
>                         pr_debug("elf: failed to find symbol table ELF se=
ctions in '%s'\n",
> -                                binary_path);
> +                               binary_path);

please don't change unrelated lines of code

>                         continue;
>                 }
>                 if (!gelf_getshdr(scn, &sh))
> @@ -10705,16 +10771,60 @@ static long elf_find_func_offset(Elf *elf, cons=
t char *binary_path, const char *
>                         if (!sname)
>                                 continue;
>
> -                       curr_bind =3D GELF_ST_BIND(sym.st_info);
> +                       if (is_name_qualified) {
> +                               Elf64_Versym *versym;
> +                               Elf64_Verdaux *verdaux;

why are we assuming 64-bit binaries?

> +                               int res;
> +                               char full_name[256];
>
> -                       /* User can specify func, func@@LIB or func@@LIB_=
VERSION. */
> -                       if (strncmp(sname, name, name_len) !=3D 0)
> -                               continue;
> -                       /* ...but we don't want a search for "foo" to mat=
ch 'foo2" also, so any
> -                        * additional characters in sname should be of th=
e form "@@LIB".
> -                        */
> -                       if (!is_name_qualified && sname[name_len] !=3D '\=
0' && sname[name_len] !=3D '@')
> -                               continue;
> +                               /* check that name at least starts with s=
name before building
> +                                * the full name
> +                                */
> +                               if (strncmp(name, sname, strlen(sname)) !=
=3D 0)
> +                                       continue;
> +
> +                               if (!versym_data || !verdef_data) {
> +                                       pr_warn("elf: failed to find vers=
ion definition or version symbol table in '%s'\n",
> +                                               binary_path);
> +                                       break;
> +                               }
> +
> +                               versym =3D elf_versym_by_idx(versym_data,=
 idx);
> +                               if (!versym) {
> +                                       pr_warn("elf: failed to lookup ve=
rsym for '%s' in '%s'\n",
> +                                               sname, binary_path);
> +                                       continue;
> +                               }
> +
> +                               verdaux =3D elf_get_verdaux_by_versym(ver=
def_data, versym);
> +                               if (!verdaux) {
> +                                       pr_warn("elf: failed to lookup ve=
rdaux for '%s' in '%s'\n",
> +                                               sname, binary_path);
> +                                       continue;
> +                               }
> +
> +                               res =3D snprintf(full_name, sizeof(full_n=
ame),
> +                                              (*versym & ELF_VERSYM_HIDD=
EN) ? "%s@%s" :
> +                                                                   "%s@@=
%s",
> +                                              sname,
> +                                              elf_strptr(elf, verdef_str=
idx,
> +                                                         verdaux->vda_na=
me));
> +
> +                               if (res < 0 || res >=3D sizeof(full_name)=
) {
> +                                       pr_warn("elf: failed to build ful=
l name for '%s' in '%s'\n",
> +                                               sname, binary_path);
> +                                       continue;
> +                               }

maybe this version fetching part can be extracted into a helper to
keep the main logic more straightforward?

> +
> +                               if (strcmp(full_name, name) !=3D 0)
> +                                       continue;
> +                       } else {
> +                               /* If name is not qualified, we want to m=
atch the symbol name */
> +                               if (strcmp(sname, name) !=3D 0)
> +                                       continue;
> +                       }
> +
> +                       curr_bind =3D GELF_ST_BIND(sym.st_info);
>
>                         if (ret >=3D 0) {
>                                 /* handle multiple matches */
> diff --git a/tools/testing/selftests/bpf/prog_tests/attach_probe.c b/tool=
s/testing/selftests/bpf/prog_tests/attach_probe.c
> index 7175af39134f..c3f33f7e9d12 100644
> --- a/tools/testing/selftests/bpf/prog_tests/attach_probe.c
> +++ b/tools/testing/selftests/bpf/prog_tests/attach_probe.c

please split selftests into a separate patch

Also, it's not great that we rely on specific GLIBC versions for
testing. There is no need to rely on glibc here at all. We have our
own test executable and shared library, urandom_read and
liburandom_read.so, which are used exactly for these sort of tests.

While I was trying to understand all this versioning  some more, I've
wrote a bunch of code already. Please use it as a base and switch
tests to these new urandom_api() (v1 and v2) functions:

diff --git a/tools/testing/selftests/bpf/Makefile
b/tools/testing/selftests/bpf/Makefile
index c49e5403ad0e..ff8685aac28f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -181,11 +181,12 @@ endif

 # Filter out -static for liburandom_read.so and its dependent targets
so that static builds
 # do not fail. Static builds leave urandom_read relying on
system-wide shared libraries.
-$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
+$(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
liburandom_read.map
        $(call msg,LIB,,$@)
        $(Q)$(CLANG) $(filter-out -static,$(CFLAGS) $(LDFLAGS))   \
-                    $^ $(filter-out -static,$(LDLIBS))      \
+                    $(filter %.c,$^) $(filter-out -static,$(LDLIBS))      =
  \
                     -fuse-ld=3D$(LLD) -Wl,-znoseparate-code -Wl,--build-id=
=3Dsha1 \
+                    -Wl,--version-script=3Dliburandom_read.map
         \
                     -fPIC -shared -o $@

 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c
$(OUTPUT)/liburandom_read.so
diff --git a/tools/testing/selftests/bpf/urandom_read.c
b/tools/testing/selftests/bpf/urandom_read.c
index e92644d0fa75..36ccfeb63443 100644
--- a/tools/testing/selftests/bpf/urandom_read.c
+++ b/tools/testing/selftests/bpf/urandom_read.c
@@ -21,6 +21,10 @@ void urand_read_without_sema(int iter_num, int
iter_cnt, int read_sz);
 void urandlib_read_with_sema(int iter_num, int iter_cnt, int read_sz);
 void urandlib_read_without_sema(int iter_num, int iter_cnt, int read_sz);

+int urandlib_api(void);
+__asm__(".symver urandlib_api_old,urandlib_api@LIBURANDOM_READ_1.0.0");
+int urandlib_api_old(void);
+
 unsigned short urand_read_with_sema_semaphore SEC(".probes");

 static __attribute__((noinline))
@@ -83,6 +87,9 @@ int main(int argc, char *argv[])

        urandom_read(fd, count);

+       urandlib_api();
+       urandlib_api_old();
+
        close(fd);
        return 0;
 }
diff --git a/tools/testing/selftests/bpf/urandom_read_lib1.c
b/tools/testing/selftests/bpf/urandom_read_lib1.c
index 86186e24b740..eb02b8a9032c 100644
--- a/tools/testing/selftests/bpf/urandom_read_lib1.c
+++ b/tools/testing/selftests/bpf/urandom_read_lib1.c
@@ -11,3 +11,37 @@ void urandlib_read_with_sema(int iter_num, int
iter_cnt, int read_sz)
 {
        STAP_PROBE3(urandlib, read_with_sema, iter_num, iter_cnt, read_sz);
 }
+
+/* Symbol versioning is different between static and shared library.
+ * Properly versioned symbols are needed for shared library, but
+ * only the symbol of the new version is needed for static library.
+ * Starting with GNU C 10, use symver attribute instead of .symver assembl=
er
+ * directive, which works better with GCC LTO builds.
+ */
+#if defined(__GNUC__) && __GNUC__ >=3D 10
+
+#define DEFAULT_VERSION(internal_name, api_name, version) \
+       __attribute__((symver(#api_name "@@" #version)))
+#define OMPAT_VERSION(internal_name, api_name, version) \
+       __attribute__((symver(#api_name "@" #version)))
+
+#else
+
+#define COMPAT_VERSION(internal_name, api_name, version) \
+       asm(".symver " #internal_name "," #api_name "@" #version);
+#define DEFAULT_VERSION(internal_name, api_name, version) \
+       asm(".symver " #internal_name "," #api_name "@@" #version);
+
+#endif
+
+COMPAT_VERSION(urandlib_api_v1, urandlib_api, LIBURANDOM_READ_1.0.0)
+int urandlib_api_v1(void)
+{
+       return 1;
+}
+
+DEFAULT_VERSION(urandlib_api_v2, urandlib_api, LIBURANDOM_READ_2.0.0)
+int urandlib_api_v2(void)
+{
+       return 2;
+}


> @@ -192,6 +192,41 @@ static void test_uprobe_lib(struct test_attach_probe=
 *skel)
>         ASSERT_EQ(skel->bss->uretprobe_byname2_res, 8, "check_uretprobe_b=
yname2_res");
>  }
>
> +static void test_uprobe_lib_with_versions(struct test_attach_probe *skel=
)
> +{
> +       DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> +       char absolute_path[256];
> +
> +       /* test attach with a versioned name.
> +        * realpath has two implementations in libc, only the default ver=
sion will be used.
> +        */
> +       uprobe_opts.func_name =3D "realpath@@GLIBC_2.3";
> +       uprobe_opts.retprobe =3D false;
> +       skel->links.handle_uprobe_byversionedname_a =3D
> +                       bpf_program__attach_uprobe_opts(skel->progs.handl=
e_uprobe_byversionedname_a,
> +                                                       0 /* this pid */,
> +                                                       "libc.so.6",
> +                                                       0, &uprobe_opts);
> +       if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byversionedname_a, "=
attach_handle_uprobe_byversionedname_a"))
> +               return;
> +
> +       uprobe_opts.func_name =3D "realpath@GLIBC_2.2.5";
> +       uprobe_opts.retprobe =3D false;
> +       skel->links.handle_uprobe_byversionedname_b =3D
> +                       bpf_program__attach_uprobe_opts(skel->progs.handl=
e_uprobe_byversionedname_b,
> +                                                       0 /* this pid */,
> +                                                       "libc.so.6",
> +                                                       0, &uprobe_opts);
> +       if (!ASSERT_OK_PTR(skel->links.handle_uprobe_byversionedname_b, "=
attach_handle_uprobe_byversionedname_b"))
> +               return;
> +
> +       /* trigger & validate probes */
> +       realpath("/", absolute_path);
> +
> +       ASSERT_EQ(skel->bss->uprobe_byversionedname_a_res, 13, "check_upr=
obe_byversionedname_a_res");
> +       ASSERT_NEQ(skel->bss->uprobe_byversionedname_b_res, 14, "check_up=
robe_byversionedname_b_res");
> +}
> +
>  static void test_uprobe_ref_ctr(struct test_attach_probe *skel)
>  {
>         DECLARE_LIBBPF_OPTS(bpf_uprobe_opts, uprobe_opts);
> @@ -316,6 +351,8 @@ void test_attach_probe(void)
>                 test_kprobe_sleepable();
>         if (test__start_subtest("uprobe-lib"))
>                 test_uprobe_lib(skel);
> +       if (test__start_subtest("uprobe-lib-with-versions"))
> +               test_uprobe_lib_with_versions(skel);
>         if (test__start_subtest("uprobe-sleepable"))
>                 test_uprobe_sleepable(skel);
>         if (test__start_subtest("uprobe-ref_ctr"))
> diff --git a/tools/testing/selftests/bpf/progs/test_attach_probe.c b/tool=
s/testing/selftests/bpf/progs/test_attach_probe.c
> index 68466a6ad18c..079b58901ff8 100644
> --- a/tools/testing/selftests/bpf/progs/test_attach_probe.c
> +++ b/tools/testing/selftests/bpf/progs/test_attach_probe.c
> @@ -17,6 +17,8 @@ int uprobe_byname3_sleepable_res =3D 0;
>  int uprobe_byname3_res =3D 0;
>  int uretprobe_byname3_sleepable_res =3D 0;
>  int uretprobe_byname3_res =3D 0;
> +int uprobe_byversionedname_a_res =3D 0;
> +int uprobe_byversionedname_b_res =3D 0;
>  void *user_ptr =3D 0;
>
>  SEC("ksyscall/nanosleep")
> @@ -121,5 +123,18 @@ int handle_uretprobe_byname3(struct pt_regs *ctx)
>         return 0;
>  }
>
> +SEC("uprobe")
> +int BPF_UPROBE(handle_uprobe_byversionedname_a, const char *a, char *b)
> +{
> +       uprobe_byversionedname_a_res =3D 13;
> +       return 0;
> +}
> +
> +SEC("uprobe")
> +int BPF_UPROBE(handle_uprobe_byversionedname_b, const char *a, char *b)
> +{
> +       uprobe_byversionedname_b_res =3D 14;
> +       return 0;
> +}
>
>  char _license[] SEC("license") =3D "GPL";
> --
> 2.34.1
>
