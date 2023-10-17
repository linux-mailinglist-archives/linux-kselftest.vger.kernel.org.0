Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FA77CD0FA
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJQXoU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjJQXoU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:44:20 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE8998;
        Tue, 17 Oct 2023 16:44:18 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-79fa387fb96so252360639f.1;
        Tue, 17 Oct 2023 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697586258; x=1698191058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ohHIZcoba9TQLafzvbzxe3RQ2VIKDug3+l1pzBAtoM=;
        b=cMMpINLb4L96SByo8koQNzAv/kiAhU1jLM1aF3G+VN+AvzueoW5PPbY03b9osKxMbk
         fweRwJGyZC0jLFngDBZbBCuqrR3+fNKNS0Y3JAOz9oteMYx2C0nvQRc6cHfru7tIExBO
         gafbx5MXRo0WW9ZObIk8CDdwAwVmBWYziqZN89U6M9RYFq45+6HF9np8q5DPlTiL4MFJ
         iW5c+MV0ec1PIdsxczR46FVvjnV62m8mvcV8VXDR2eSEbAla+n4htX0FuVr5WRttEwjp
         Q7DW+FWrtCLCsL+2dQZ+WzBl65ZmORH4fMbejFkBi2/nRfwFgL+GdftQFGcTCp+xim64
         yeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697586258; x=1698191058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ohHIZcoba9TQLafzvbzxe3RQ2VIKDug3+l1pzBAtoM=;
        b=N4+UNAyek0HyqIO1zeYgKGHlA0wDhlhW9jQf7vj+0KSymvaFjQJfPt/rKZKoknnKZu
         nF5zCnh6B5P+tu/q1VScrLKn8eWVx2k8Z0S2lxBM+QH1L30Rx7VxmiA6jSUNVIR6hCik
         S8E28GI2vEFuB2rcM3rasxnK9w2LC53Jdg5GC+OG3sMsYzP4MIbAZe8xJC/nggiRjGf5
         bSkrUJQ5Cs51tJcVvLL1gh7mnK+pxh8pY4UDPgqVfYTkJCbOKG4XFXBg1SQGC2kuHqV3
         Gj9sP+yRbLpG/VTPEw+T0lOBu1lx+LwTRrCQX+ox2UjnP20kX8pfo5wfIzBi8AA4HHfa
         c+/w==
X-Gm-Message-State: AOJu0YyzNpBlDOWG/3Mgen4d/41mvfiYGH+8qoWBJHRwOLUV4z9C4is1
        mvyOov2ws46Q4YS/vPu5IuNjZ2DXvjcvB33q0Xc=
X-Google-Smtp-Source: AGHT+IGXY+lwr696u/PyGmcc9AnBMzb4/ngDk7vjr/QOcTo4jjPgueWhbOhlQfLgiNq+aEj3+JKn1wAVSH0Txz3p/Cs=
X-Received: by 2002:a05:6602:1692:b0:79f:e481:fe31 with SMTP id
 s18-20020a056602169200b0079fe481fe31mr4531316iow.3.1697586258062; Tue, 17 Oct
 2023 16:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231017232152.2605440-5-nphamcs@gmail.com>
 <CAKEwX=N+z779m2mdniiccs=+24XRBDZjqZbE7FAUm6vfnjG+qQ@mail.gmail.com>
In-Reply-To: <CAKEwX=N+z779m2mdniiccs=+24XRBDZjqZbE7FAUm6vfnjG+qQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 17 Oct 2023 16:44:05 -0700
Message-ID: <CAKEwX=OKoixUrR_cN4u3T_Sf_6PWC2U=G28opNcrN4u7Tv4aXQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests: cgroup: update per-memcg zswap
 writeback selftest
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 4:34=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Tue, Oct 17, 2023 at 4:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> >
> > The memcg-zswap self test is updated to adjust to the behavior change
> > implemented by commit 87730b165089 ("zswap: make shrinking memcg-aware"=
),
> > where zswap performs writeback for specific memcg.
> >
> > Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> /s/Signed-off/Acked
> This is Domenico's work :) I used the wrong tag here. Should be:
> Acked-by: Nhat Pham <nphamcs@gmail.com>

Please ignore this comment - it was pointed out to me that Signed-off is
the appropriate tag here.

>
> > ---
> >  tools/testing/selftests/cgroup/test_zswap.c | 74 ++++++++++++++-------
> >  1 file changed, 50 insertions(+), 24 deletions(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testin=
g/selftests/cgroup/test_zswap.c
> > index 49def87a909b..11271fabeffc 100644
> > --- a/tools/testing/selftests/cgroup/test_zswap.c
> > +++ b/tools/testing/selftests/cgroup/test_zswap.c
> > @@ -50,9 +50,9 @@ static int get_zswap_stored_pages(size_t *value)
> >         return read_int("/sys/kernel/debug/zswap/stored_pages", value);
> >  }
> >
> > -static int get_zswap_written_back_pages(size_t *value)
> > +static int get_cg_wb_count(const char *cg)
> >  {
> > -       return read_int("/sys/kernel/debug/zswap/written_back_pages", v=
alue);
> > +       return cg_read_key_long(cg, "memory.stat", "zswap_wb");
> >  }
> >
> >  static int allocate_bytes(const char *cgroup, void *arg)
> > @@ -68,45 +68,71 @@ static int allocate_bytes(const char *cgroup, void =
*arg)
> >         return 0;
> >  }
> >
> > +static char *setup_test_group_1M(const char *root, const char *name)
> > +{
> > +       char *group_name =3D cg_name(root, name);
> > +
> > +       if (!group_name)
> > +               return NULL;
> > +       if (cg_create(group_name))
> > +               goto fail;
> > +       if (cg_write(group_name, "memory.max", "1M")) {
> > +               cg_destroy(group_name);
> > +               goto fail;
> > +       }
> > +       return group_name;
> > +fail:
> > +       free(group_name);
> > +       return NULL;
> > +}
> > +
> >  /*
> >   * When trying to store a memcg page in zswap, if the memcg hits its m=
emory
> > - * limit in zswap, writeback should not be triggered.
> > - *
> > - * This was fixed with commit 0bdf0efa180a("zswap: do not shrink if cg=
roup may
> > - * not zswap"). Needs to be revised when a per memcg writeback mechani=
sm is
> > - * implemented.
> > + * limit in zswap, writeback should affect only the zswapped pages of =
that
> > + * memcg.
> >   */
> >  static int test_no_invasive_cgroup_shrink(const char *root)
> >  {
> > -       size_t written_back_before, written_back_after;
> >         int ret =3D KSFT_FAIL;
> > -       char *test_group;
> > +       size_t control_allocation_size =3D MB(10);
> > +       char *control_allocation, *wb_group =3D NULL, *control_group =
=3D NULL;
> >
> >         /* Set up */
> > -       test_group =3D cg_name(root, "no_shrink_test");
> > -       if (!test_group)
> > -               goto out;
> > -       if (cg_create(test_group))
> > +       wb_group =3D setup_test_group_1M(root, "per_memcg_wb_test1");
> > +       if (!wb_group)
> > +               return KSFT_FAIL;
> > +       if (cg_write(wb_group, "memory.zswap.max", "10K"))
> >                 goto out;
> > -       if (cg_write(test_group, "memory.max", "1M"))
> > +       control_group =3D setup_test_group_1M(root, "per_memcg_wb_test2=
");
> > +       if (!control_group)
> >                 goto out;
> > -       if (cg_write(test_group, "memory.zswap.max", "10K"))
> > +
> > +       /* Push some test_group2 memory into zswap */
> > +       if (cg_enter_current(control_group))
> >                 goto out;
> > -       if (get_zswap_written_back_pages(&written_back_before))
> > +       control_allocation =3D malloc(control_allocation_size);
> > +       for (int i =3D 0; i < control_allocation_size; i +=3D 4095)
> > +               control_allocation[i] =3D 'a';
> > +       if (cg_read_key_long(control_group, "memory.stat", "zswapped") =
< 1)
> >                 goto out;
> >
> > -       /* Allocate 10x memory.max to push memory into zswap */
> > -       if (cg_run(test_group, allocate_bytes, (void *)MB(10)))
> > +       /* Allocate 10x memory.max to push wb_group memory into zswap a=
nd trigger wb */
> > +       if (cg_run(wb_group, allocate_bytes, (void *)MB(10)))
> >                 goto out;
> >
> > -       /* Verify that no writeback happened because of the memcg alloc=
ation */
> > -       if (get_zswap_written_back_pages(&written_back_after))
> > -               goto out;
> > -       if (written_back_after =3D=3D written_back_before)
> > +       /* Verify that only zswapped memory from gwb_group has been wri=
tten back */
> > +       if (get_cg_wb_count(wb_group) > 0 && get_cg_wb_count(control_gr=
oup) =3D=3D 0)
> >                 ret =3D KSFT_PASS;
> >  out:
> > -       cg_destroy(test_group);
> > -       free(test_group);
> > +       cg_enter_current(root);
> > +       if (control_group) {
> > +               cg_destroy(control_group);
> > +               free(control_group);
> > +       }
> > +       cg_destroy(wb_group);
> > +       free(wb_group);
> > +       if (control_allocation)
> > +               free(control_allocation);
> >         return ret;
> >  }
> >
> > --
> > 2.34.1
