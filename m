Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB8769A94
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 17:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjGaPQI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGaPQH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 11:16:07 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4559C3
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 08:16:06 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2680eee423aso2543712a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 08:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690816566; x=1691421366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kll08k0DNMi1T/P0iInnWv1KYBtw1gwydWZTDG2X+Z4=;
        b=P6uLmpFptHlYkGL0BwYwq7jfx89YNAAaS8zjdDRT6Y6kx/1FRSuhc/rrE4l3LYgR0M
         kpXX3jGSwqcqd7ELsnkpyTPbjjzJsEhRyE/c4jlCDBdGDB2seO4vp5Eg/0cmNepaoP04
         3xWYagLX+hnnJZkwd5xHVNv4Ksvcx76Vj6gQrr6GvanWNa5FE5wOdEAZORqVJn9dBv9z
         vCBPB5MEftts93oXirvpHzsiPc96fXir/YrDOBJGL5vaprTtUIt1pzEh1x2KsmklI3q0
         c7EEZShZhpP+COxHl0U+ZqgXUqKb6AzS8wtS/aLSz4OMB3uDYTqp+OAaBGpSUHW4JB9x
         PsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690816566; x=1691421366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kll08k0DNMi1T/P0iInnWv1KYBtw1gwydWZTDG2X+Z4=;
        b=OTqWvJEj0r7jDGTYXIym7/yvAli8yIXUePQNULQEY49WT59oQU/A+WNRdp5+Wk9oXl
         OscjH/+2UqLiI5NeCXkMhx08n37r8G+K8CRABnGFXSetGuRds2QEKIWXe7a2QotYisx9
         qhpgN4/BhZTJRE9sZsF6sFe6LcrY520PjttVIFT1CcH3+KzM+K4LJBE5xjW2lY7UuvGq
         0XmB/d9kfoAoOeA3P7Mc/ZhXt1iAzWTC1/2WQ1XL7/aXafuo/nKUGcvfIdUK8k+76fWn
         M7hKHWMc8fnQI/DRgKMXVPHay1afjD+83uEI2jvXSOfV7nTkNYiEtH2SLhuE0oO1QbEf
         Uzig==
X-Gm-Message-State: ABy/qLarTbdPI2VU0Lxcw6Ty2CBTbISl3pgQMBS4NF9VUhsShfg7cA0S
        Yz/A7yqx07JmjVlnhLlWdT44iK3BuRkzhPSvYVHnUIA+
X-Google-Smtp-Source: APBJJlE6xncbk87X033cmsArzzJVWeZJa5YpGCV4W5hAOPL79unA3qvGFTEMiM9KKBq0i/pMsNoX/UlsVd7xIzSYdEI=
X-Received: by 2002:a17:90a:1b48:b0:262:df91:cdce with SMTP id
 q66-20020a17090a1b4800b00262df91cdcemr9009352pjq.23.1690816566110; Mon, 31
 Jul 2023 08:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <5f082f85-0256-4c48-9ae2-6440297317b8@moroto.mountain>
In-Reply-To: <5f082f85-0256-4c48-9ae2-6440297317b8@moroto.mountain>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Mon, 31 Jul 2023 17:15:54 +0200
Message-ID: <CA+CLi1ivsM09=G_9=WCa=5=RPNX_B1pgE7G127Hv4Az+3nGOVQ@mail.gmail.com>
Subject: Re: [bug report] selftests: cgroup: add test_zswap with no kmem
 bypass test
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 31, 2023 at 4:18=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> Hello Domenico Cerasuolo,
>
> The patch 7c967f267b1d: "selftests: cgroup: add test_zswap with no
> kmem bypass test" from Jun 21, 2023 (linux-next), leads to the
> following Smatch static checker warning:
>
>         ./tools/testing/selftests/cgroup/test_zswap.c:228 test_no_kmem_by=
pass()
>         error: uninitialized symbol 'test_group'.
>
> ./tools/testing/selftests/cgroup/test_zswap.c
>     148 static int test_no_kmem_bypass(const char *root)
>     149 {
>     150         size_t min_free_kb_high, min_free_kb_low, min_free_kb_ori=
ginal;
>     151         struct no_kmem_bypass_child_args *values;
>     152         size_t trigger_allocation_size;
>     153         int wait_child_iteration =3D 0;
>     154         long stored_pages_threshold;
>     155         struct sysinfo sys_info;
>     156         int ret =3D KSFT_FAIL;
>     157         int child_status;
>     158         char *test_group;
>     159         pid_t child_pid;
>     160
>     161         /* Read sys info and compute test values accordingly */
>     162         if (sysinfo(&sys_info) !=3D 0)
>     163                 return KSFT_FAIL;
>     164         if (sys_info.totalram > 5000000000)
>     165                 return KSFT_SKIP;
>     166         values =3D mmap(0, sizeof(struct no_kmem_bypass_child_arg=
s), PROT_READ |
>     167                         PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -=
1, 0);
>     168         if (values =3D=3D MAP_FAILED)
>     169                 return KSFT_FAIL;
>     170         if (read_min_free_kb(&min_free_kb_original))
>     171                 return KSFT_FAIL;
>     172         min_free_kb_high =3D sys_info.totalram / 2000;
>     173         min_free_kb_low =3D sys_info.totalram / 500000;
>     174         values->target_alloc_bytes =3D (sys_info.totalram - min_f=
ree_kb_high * 1000) +
>     175                 sys_info.totalram * 5 / 100;
>     176         stored_pages_threshold =3D sys_info.totalram / 5 / 4096;
>     177         trigger_allocation_size =3D sys_info.totalram / 20;
>     178
>     179         /* Set up test memcg */
>     180         if (cg_write(root, "cgroup.subtree_control", "+memory"))
>     181                 goto out;
>
> test_group is not initialized here.  Undoing stuff which hasn't been
> done is the canonical bug with "goto out;" labels.

True, this goto out and next one should just be return.

>
>     182         test_group =3D cg_name(root, "kmem_bypass_test");
>     183         if (!test_group)
>     184                 goto out;
>     185
>     186         /* Spawn memcg child and wait for it to allocate */
>     187         set_min_free_kb(min_free_kb_low);
>     188         if (cg_create(test_group))
>
> test_group is allocated but not created.  Is it okay to call
> destroy on this path?

It is, cg_destroy() just returns 0 if the path doesn't exist.

>
>     189                 goto out;
>     190         values->child_allocated =3D false;
>     191         child_pid =3D cg_run_nowait(test_group, no_kmem_bypass_ch=
ild, values);
>     192         if (child_pid < 0)
>     193                 goto out;
>     194         while (!values->child_allocated && wait_child_iteration++=
 < 10000)
>     195                 usleep(1000);
>     196
>     197         /* Try to wakeup kswapd and let it push child memory to z=
swap */
>     198         set_min_free_kb(min_free_kb_high);
>     199         for (int i =3D 0; i < 20; i++) {
>     200                 size_t stored_pages;
>     201                 char *trigger_allocation =3D malloc(trigger_alloc=
ation_size);
>     202
>     203                 if (!trigger_allocation)
>     204                         break;
>     205                 for (int i =3D 0; i < trigger_allocation_size; i =
+=3D 4095)
>     206                         trigger_allocation[i] =3D 'b';
>     207                 usleep(100000);
>     208                 free(trigger_allocation);
>     209                 if (get_zswap_stored_pages(&stored_pages))
>     210                         break;
>     211                 if (stored_pages < 0)
>     212                         break;
>     213                 /* If memory was pushed to zswap, verify it belon=
gs to memcg */
>     214                 if (stored_pages > stored_pages_threshold) {
>     215                         int zswapped =3D cg_read_key_long(test_gr=
oup, "memory.stat", "zswapped ");
>     216                         int delta =3D stored_pages * 4096 - zswap=
ped;
>     217                         int result_ok =3D delta < stored_pages * =
4096 / 4;
>     218
>     219                         ret =3D result_ok ? KSFT_PASS : KSFT_FAIL=
;
>     220                         break;
>     221                 }
>     222         }
>     223
>     224         kill(child_pid, SIGTERM);
>     225         waitpid(child_pid, &child_status, 0);
>     226 out:
>     227         set_min_free_kb(min_free_kb_original);
> --> 228         cg_destroy(test_group);
>     229         free(test_group);
>     230         return ret;
>     231 }
>
> regards,
> dan carpenter

Thanks again, will fix this too!

Domenico
