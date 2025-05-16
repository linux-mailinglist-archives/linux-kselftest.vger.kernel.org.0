Return-Path: <linux-kselftest+bounces-33175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C89AB9C8B
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 14:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964DFA001CE
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 12:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B245122F176;
	Fri, 16 May 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWpjjs01"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2261DFDE
	for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399761; cv=none; b=rt0zWNxnxDQtjW0fjOGgMtSls0xxiLFCg4DGxV7VRsfjvz/Q7KXr7T5EW1ZeW/L90H2eDSmHg+h+TUgb59/ggRBI/teg4R2cgGoaUj+tF3PZzLJeI30nHPAf2X4hHY/0XF2VQvfMaMr5xpmu834y+sAKIf5Wjq6FOs2oCSPGdHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399761; c=relaxed/simple;
	bh=GcKFrgreIvu/DcufqEXnox754v04KYjC96HK/9/Cuxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iOUA/9i2r38VVK3ZKgYMRrFCh4TJQ7W3Yi7viOTMhEpnrc5tLjWikJRo9cdgABVaaJd7Z/T92uqt8rsHSz2Ul6eucNyXs4tZ03VC5Kbv6+DsLYzNQVLuwpmc3Xw4mu82i8GXgJOIATx9wQYKTrddWzclhxPtDmr0a6PQLtsstZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWpjjs01; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a0b9c371d8so1790514f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 16 May 2025 05:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747399757; x=1748004557; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gd80t/X/Ixcnvoe4YAhonXwlzyGIAaV2hwyO2dMbv80=;
        b=AWpjjs01776+EaZ1m86D3j2OjRzq/vvLTUFondprydwTScYl68b7RyIitXNYUQJzWa
         gF/Y/25AuzOqDg9zLUoC3aXs7e84z7YBZ7E6B/wm2R40wphr93BEN+0xUDw/ki8l5JXF
         OqbfReA5w7Ff6GMrUgbcVRjZ5TRcdbedkC0SpKudEmMEJP6OLx0c5euMWf+96VuN395C
         F6AE9o0rveH0xxI2MMjDTkSArMXvSFtC+iB80183pew0Pk7f8vltW33N191KGiSI8gGL
         NSeRlCfu9wMPWQ1PgbMRiRgcjKdP+y0xvAIeo8gkVtnaFmX+K+Ed4bTNl8sPdGDnMTOb
         CBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747399757; x=1748004557;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gd80t/X/Ixcnvoe4YAhonXwlzyGIAaV2hwyO2dMbv80=;
        b=MLdx+y6C0LNmJVJPmq0Uer9174/cucbX7IetW+bCaRXKNq1wWMyLd+W712RwaRE1Ci
         HLOJXfhsOFT2z01H54+RZmIpH5i1/RaJSdsoXnYh7M2cn0bJp26lWeWROWMBBOul2VAL
         AV0NLtK51fzgVJgQ+kg7UiVr+kHteprWQjud7BNEeDNcXGJHN1m3h+bRWXZJ8kItSsYw
         BeVeFgNOUV3F1GX92a9JBJyLLefHCPstRds1WT8765pQOVjLacltyBRtVujolw5CPeVq
         FFhDvo6Q0UBdzT2fSrBeXLkfuVZWVsJv1B6wE/NRTyq7NTti4ZehZjTZwOZx5Yzp7fZ+
         vvHA==
X-Gm-Message-State: AOJu0YwATOnb4ongg6Jtj5X9sa0GzMBiL3yMLhZQofIYgP+4QmjCe7hb
	3vZmIfCF9iCDhCIthw6IuLpdlFVAOHRzYHYUdI7pXi3FtYfB/5IK299/dhgwA+hXaeBiM9m7Bjc
	nTN99Jw4rQ/If5IUDNWMHVvJqxvVGJQ+UaF8S
X-Gm-Gg: ASbGncu8Pp+XpPrQPmIhw+r69K4MSMXUcWDSqmZ7D+MewT9FZtLwDkdQ+ebfVgzzf/8
	xIFpbCqfC1DFaoxROE3q1N8BNPNGgk8cRpgFdZc0z+TAQZPsbgLaUHaZgTX7/ZddHa+d3nPjUGX
	oCc2SndLTVG4HY64688bdDwk1C8NhYSOOjUA==
X-Google-Smtp-Source: AGHT+IEZOgk24WDVrdXfmUrnvRSLJ8rrFFYjS/1ehThuhBBwOoCA3ZyDw/PDikcg2T90nPAIZk+lewFNukmfR4NB6ZA=
X-Received: by 2002:adf:f30f:0:b0:3a3:60f0:e2eb with SMTP id
 ffacd0b85a97d-3a360f0e520mr1908967f8f.33.1747399757019; Fri, 16 May 2025
 05:49:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516124146.94932-1-suresh.k.chandrappa@gmail.com>
In-Reply-To: <20250516124146.94932-1-suresh.k.chandrappa@gmail.com>
From: Suresh Chandrappa <suresh.k.chandrappa@gmail.com>
Date: Fri, 16 May 2025 18:19:05 +0530
X-Gm-Features: AX0GCFul6L9KFyrIUWBj3Na838lGcaj7MMlCTWX1LwvD46Lc9Tfz7izyDS-3nsk
Message-ID: <CAAMO5piApUjK-OwGbA7N78b54amMb68Cxch92AG-6PiqSy9q4A@mail.gmail.com>
Subject: Re: [PATCH] selftests: cachestat: add mmap test and /proc/cpuinfo
 test case
To: linux-kselftest@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cc5ce8063540359b"

--000000000000cc5ce8063540359b
Content-Type: multipart/alternative; boundary="000000000000cc5ce70635403599"

--000000000000cc5ce70635403599
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ms.Khan

I have added a new api *test_cachestat_mmap *to validate cachestat behavior
with memory-mapped files.
attached the output file here.

Thanks,
Suresh K C

On Fri, May 16, 2025 at 6:12=E2=80=AFPM Suresh K C <suresh.k.chandrappa@gma=
il.com>
wrote:

> From: Suresh K C <suresh.k.chandrappa@gmail.com>
>
> This patch adds a new test case to validate cachestat behavior with
> memory-mapped files using mmap(). The test ensures that pages are
> properly cached when accessed via mmap and verifies the expected
> number of cached pages.
>
> Additionally, a test case for /proc/cpuinfo has been added to observe
> how cachestat handles virtual files under /proc. This helps improve
> coverage of edge cases involving pseudo-filesystems
>
> Signed-off-by: Suresh K C <suresh.k.chandrappa@gmail.com>
> ---
>  .../selftests/cachestat/test_cachestat.c      | 69 ++++++++++++++++++-
>  1 file changed, 67 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c
> b/tools/testing/selftests/cachestat/test_cachestat.c
> index 632ab44737ec..81e7f6dd2279 100644
> --- a/tools/testing/selftests/cachestat/test_cachestat.c
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -22,7 +22,7 @@
>
>  static const char * const dev_files[] =3D {
>         "/dev/zero", "/dev/null", "/dev/urandom",
> -       "/proc/version", "/proc"
> +       "/proc/version","/proc/cpuinfo","/proc"
>  };
>
>  void print_cachestat(struct cachestat *cs)
> @@ -202,6 +202,65 @@ static int test_cachestat(const char *filename, bool
> write_random, bool create,
>         return ret;
>  }
>
> +bool test_cachestat_mmap(void){
> +
> +       size_t PS =3D sysconf(_SC_PAGESIZE);
> +       size_t filesize =3D PS * 512 * 2;;
> +       int syscall_ret;
> +       size_t compute_len =3D PS * 512;
> +       struct cachestat_range cs_range =3D { PS, compute_len };
> +       char *filename =3D "tmpshmcstat";
> +       unsigned long num_pages =3D compute_len / PS;
> +       struct cachestat cs;
> +       bool ret =3D true;
> +       int fd =3D open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
> +       if (fd < 0) {
> +               ksft_print_msg("Unable to create mmap file.\n");
> +               ret =3D false;
> +               goto out;
> +       }
> +       if (ftruncate(fd, filesize)) {
> +               ksft_print_msg("Unable to truncate mmap file.\n");
> +               ret =3D false;
> +               goto close_fd;
> +       }
> +       if (!write_exactly(fd, filesize)) {
> +               ksft_print_msg("Unable to write to mmap file.\n");
> +               ret =3D false;
> +               goto close_fd;
> +       }
> +       char *map =3D mmap(NULL, filesize, PROT_READ | PROT_WRITE,
> MAP_SHARED, fd, 0);
> +       if (map =3D=3D MAP_FAILED) {
> +               ksft_print_msg("mmap failed.\n");
> +               ret =3D false;
> +               goto close_fd;
> +       }
> +
> +       for (int i =3D 0; i < filesize; i++) {
> +               map[i] =3D 'A';
> +       }
> +       map[filesize - 1] =3D 'X';
> +
> +       syscall_ret =3D syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
> +
> +       if (syscall_ret) {
> +               ksft_print_msg("Cachestat returned non-zero.\n");
> +               ret =3D false;
> +       } else {
> +               print_cachestat(&cs);
> +               if (cs.nr_cache + cs.nr_evicted !=3D num_pages) {
> +                       ksft_print_msg("Total number of cached and evicte=
d
> pages is off.\n");
> +                       ret =3D false;
> +               }
> +       }
> +
> +close_fd:
> +       close(fd);
> +       unlink(filename);
> +out:
> +       return ret;
> +}
> +
>  bool test_cachestat_shmem(void)
>  {
>         size_t PS =3D sysconf(_SC_PAGESIZE);
> @@ -274,7 +333,7 @@ int main(void)
>                 ret =3D 1;
>         }
>
> -       for (int i =3D 0; i < 5; i++) {
> +       for (int i =3D 0; i < 6; i++) {
>                 const char *dev_filename =3D dev_files[i];
>
>                 if (test_cachestat(dev_filename, false, false, false,
> @@ -315,5 +374,11 @@ int main(void)
>                 ret =3D 1;
>         }
>
> +       if (test_cachestat_mmap())
> +               ksft_test_result_pass("cachestat works with a mmap
> file\n");
> +       else {
> +               ksft_test_result_fail("cachestat fails with a mmap
> file\n");
> +               ret =3D 1;
> +       }
>         return ret;
>  }
> --
> 2.43.0
>
>

--000000000000cc5ce70635403599
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Ms.Khan<div><br></div><div>I have added a new api <b>te=
st_cachestat_mmap=C2=A0</b>to validate cachestat behavior with memory-mappe=
d files.</div><div>attached the output file here.</div><div><br></div><div>=
Thanks,</div><div>Suresh K C</div></div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 16, 202=
5 at 6:12=E2=80=AFPM Suresh K C &lt;<a href=3D"mailto:suresh.k.chandrappa@g=
mail.com">suresh.k.chandrappa@gmail.com</a>&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Suresh K C &lt;<a href=3D"mail=
to:suresh.k.chandrappa@gmail.com" target=3D"_blank">suresh.k.chandrappa@gma=
il.com</a>&gt;<br>
<br>
This patch adds a new test case to validate cachestat behavior with<br>
memory-mapped files using mmap(). The test ensures that pages are<br>
properly cached when accessed via mmap and verifies the expected<br>
number of cached pages.<br>
<br>
Additionally, a test case for /proc/cpuinfo has been added to observe<br>
how cachestat handles virtual files under /proc. This helps improve<br>
coverage of edge cases involving pseudo-filesystems<br>
<br>
Signed-off-by: Suresh K C &lt;<a href=3D"mailto:suresh.k.chandrappa@gmail.c=
om" target=3D"_blank">suresh.k.chandrappa@gmail.com</a>&gt;<br>
---<br>
=C2=A0.../selftests/cachestat/test_cachestat.c=C2=A0 =C2=A0 =C2=A0 | 69 +++=
+++++++++++++++-<br>
=C2=A01 file changed, 67 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/tes=
ting/selftests/cachestat/test_cachestat.c<br>
index 632ab44737ec..81e7f6dd2279 100644<br>
--- a/tools/testing/selftests/cachestat/test_cachestat.c<br>
+++ b/tools/testing/selftests/cachestat/test_cachestat.c<br>
@@ -22,7 +22,7 @@<br>
<br>
=C2=A0static const char * const dev_files[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;/dev/zero&quot;, &quot;/dev/null&quot;, &=
quot;/dev/urandom&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;/proc/version&quot;, &quot;/proc&quot;<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;/proc/version&quot;,&quot;/proc/cpuinfo&q=
uot;,&quot;/proc&quot;<br>
=C2=A0};<br>
<br>
=C2=A0void print_cachestat(struct cachestat *cs)<br>
@@ -202,6 +202,65 @@ static int test_cachestat(const char *filename, bool w=
rite_random, bool create,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
<br>
+bool test_cachestat_mmap(void){<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t PS =3D sysconf(_SC_PAGESIZE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t filesize =3D PS * 512 * 2;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int syscall_ret;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t compute_len =3D PS * 512;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cachestat_range cs_range =3D { PS, compu=
te_len };<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *filename =3D &quot;tmpshmcstat&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long num_pages =3D compute_len / PS;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct cachestat cs;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0bool ret =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int fd =3D open(filename, O_RDWR | O_CREAT | O_=
TRUNC, 0666);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ksft_print_msg(&quo=
t;Unable to create mmap file.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ftruncate(fd, filesize)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ksft_print_msg(&quo=
t;Unable to truncate mmap file.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto close_fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!write_exactly(fd, filesize)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ksft_print_msg(&quo=
t;Unable to write to mmap file.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto close_fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0char *map =3D mmap(NULL, filesize, PROT_READ | =
PROT_WRITE, MAP_SHARED, fd, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (map =3D=3D MAP_FAILED) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ksft_print_msg(&quo=
t;mmap failed.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto close_fd;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; filesize; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0map[i] =3D &#39;A&#=
39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0map[filesize - 1] =3D &#39;X&#39;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0syscall_ret =3D syscall(__NR_cachestat, fd, &am=
p;cs_range, &amp;cs, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (syscall_ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ksft_print_msg(&quo=
t;Cachestat returned non-zero.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_cachestat(&am=
p;cs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (cs.nr_cache + c=
s.nr_evicted !=3D num_pages) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ksft_print_msg(&quot;Total number of cached and evicted pages is =
off.\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+close_fd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0close(fd);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unlink(filename);<br>
+out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
+}<br>
+<br>
=C2=A0bool test_cachestat_shmem(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t PS =3D sysconf(_SC_PAGESIZE);<br>
@@ -274,7 +333,7 @@ int main(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; 5; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; 6; i++) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *dev_fil=
ename =3D dev_files[i];<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (test_cachestat(=
dev_filename, false, false, false,<br>
@@ -315,5 +374,11 @@ int main(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (test_cachestat_mmap())<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ksft_test_result_pa=
ss(&quot;cachestat works with a mmap file\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ksft_test_result_fa=
il(&quot;cachestat fails with a mmap file\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0}<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div>

--000000000000cc5ce70635403599--
--000000000000cc5ce8063540359b
Content-Type: text/plain; charset="US-ASCII"; name="test_result_cache.txt"
Content-Disposition: attachment; filename="test_result_cache.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_maqsjvvu0>
X-Attachment-Id: f_maqsjvvu0

VEFQIHZlcnNpb24gMTMKMS4uOQpvayAxIGJhZCBmaWxlIGRlc2NyaXB0b3IgcmVjb2duaXplZAoj
IENyZWF0ZS9vcGVuIC9kZXYvemVybwojIENhY2hlc3RhdCBjYWxsIHJldHVybmVkIDAKIyBVc2lu
ZyBjYWNoZXN0YXQ6IENhY2hlZDogMCwgRGlydHk6IDAsIFdyaXRlYmFjazogMCwgRXZpY3RlZDog
MCwgUmVjZW50bHkgRXZpY3RlZDogMApvayAyIGNhY2hlc3RhdCB3b3JrcyB3aXRoIC9kZXYvemVy
bwojIENyZWF0ZS9vcGVuIC9kZXYvbnVsbAojIENhY2hlc3RhdCBjYWxsIHJldHVybmVkIDAKIyBV
c2luZyBjYWNoZXN0YXQ6IENhY2hlZDogMCwgRGlydHk6IDAsIFdyaXRlYmFjazogMCwgRXZpY3Rl
ZDogMCwgUmVjZW50bHkgRXZpY3RlZDogMApvayAzIGNhY2hlc3RhdCB3b3JrcyB3aXRoIC9kZXYv
bnVsbAojIENyZWF0ZS9vcGVuIC9kZXYvdXJhbmRvbQojIENhY2hlc3RhdCBjYWxsIHJldHVybmVk
IDAKIyBVc2luZyBjYWNoZXN0YXQ6IENhY2hlZDogMCwgRGlydHk6IDAsIFdyaXRlYmFjazogMCwg
RXZpY3RlZDogMCwgUmVjZW50bHkgRXZpY3RlZDogMApvayA0IGNhY2hlc3RhdCB3b3JrcyB3aXRo
IC9kZXYvdXJhbmRvbQojIENyZWF0ZS9vcGVuIC9wcm9jL3ZlcnNpb24KIyBDYWNoZXN0YXQgY2Fs
bCByZXR1cm5lZCAtMQojIENhY2hlc3RhdCByZXR1cm5lZCBub24temVyby4Kbm90IG9rIDUgY2Fj
aGVzdGF0IGZhaWxzIHdpdGggL3Byb2MvdmVyc2lvbgojIENyZWF0ZS9vcGVuIC9wcm9jL2NwdWlu
Zm8KIyBDYWNoZXN0YXQgY2FsbCByZXR1cm5lZCAtMQojIENhY2hlc3RhdCByZXR1cm5lZCBub24t
emVyby4Kbm90IG9rIDYgY2FjaGVzdGF0IGZhaWxzIHdpdGggL3Byb2MvY3B1aW5mbwojIENyZWF0
ZS9vcGVuIC9wcm9jCiMgQ2FjaGVzdGF0IGNhbGwgcmV0dXJuZWQgLTEKIyBDYWNoZXN0YXQgcmV0
dXJuZWQgbm9uLXplcm8uCm5vdCBvayA3IGNhY2hlc3RhdCBmYWlscyB3aXRoIC9wcm9jCiMgQ3Jl
YXRlL29wZW4gdG1wZmlsZWNhY2hlc3RhdAojIENhY2hlc3RhdCBjYWxsIHJldHVybmVkIDAKIyBV
c2luZyBjYWNoZXN0YXQ6IENhY2hlZDogNCwgRGlydHk6IDQsIFdyaXRlYmFjazogMCwgRXZpY3Rl
ZDogMCwgUmVjZW50bHkgRXZpY3RlZDogMApvayA4IGNhY2hlc3RhdCB3b3JrcyB3aXRoIGEgbm9y
bWFsIGZpbGUKIyBDcmVhdGUvb3BlbiB0bXBmaWxlY2FjaGVzdGF0CiMgQ2FjaGVzdGF0IGNhbGwg
cmV0dXJuZWQgMAojIFVzaW5nIGNhY2hlc3RhdDogQ2FjaGVkOiA0LCBEaXJ0eTogNCwgV3JpdGVi
YWNrOiAwLCBFdmljdGVkOiAwLCBSZWNlbnRseSBFdmljdGVkOiAwCiMgQ2FjaGVzdGF0IGNhbGwg
KGFmdGVyIGZzeW5jKSByZXR1cm5lZCAwCiMgVXNpbmcgY2FjaGVzdGF0OiBDYWNoZWQ6IDQsIERp
cnR5OiAwLCBXcml0ZWJhY2s6IDAsIEV2aWN0ZWQ6IDAsIFJlY2VudGx5IEV2aWN0ZWQ6IDAKb2sg
OSBjYWNoZXN0YXQgZnN5bmMgd29ya3Mgd2l0aCBhIG5vcm1hbCBmaWxlCiMgVXNpbmcgY2FjaGVz
dGF0OiBDYWNoZWQ6IDUxMiwgRGlydHk6IDAsIFdyaXRlYmFjazogMCwgRXZpY3RlZDogMCwgUmVj
ZW50bHkgRXZpY3RlZDogMApvayAxMCBjYWNoZXN0YXQgd29ya3Mgd2l0aCBhIHNobWVtIGZpbGUK
IyBVc2luZyBjYWNoZXN0YXQ6IENhY2hlZDogNTEyLCBEaXJ0eTogNTEyLCBXcml0ZWJhY2s6IDAs
IEV2aWN0ZWQ6IDAsIFJlY2VudGx5IEV2aWN0ZWQ6IDAKb2sgMTEgY2FjaGVzdGF0IHdvcmtzIHdp
dGggYSBtbWFwIGZpbGUK
--000000000000cc5ce8063540359b--

