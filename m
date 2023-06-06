Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7328724CFE
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbjFFT23 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 15:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbjFFT23 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 15:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2600A10D2
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Jun 2023 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686079661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DUOI1nw4nCTceXaGk0SSalGiQc9wOhqP0PxFimWSUwU=;
        b=YCdglDPnnJS3XC937QWQAvZ6m03TQsYcmaAW24ZDnQ7W5PHNnFtydEHdsnuEwmmgPUUkGl
        kp/RbY9kauNRd55wGLmU/Pi8Ex0uObEkKZ5zZdyykFvW1JwJhjCb3aEzwDiCUsUyXAkX/n
        qVHk9BdT29KVIvfvQCtebWv/HNLBKaQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-e4OC0QMlMDePrAZKV_MKVQ-1; Tue, 06 Jun 2023 15:27:40 -0400
X-MC-Unique: e4OC0QMlMDePrAZKV_MKVQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f7e6582938so35525515e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jun 2023 12:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686079659; x=1688671659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUOI1nw4nCTceXaGk0SSalGiQc9wOhqP0PxFimWSUwU=;
        b=Lrl9NJ4pnvPKuNRBZAhTxdPsBGSVldXS8plPL2R0HhGoAMhf6hs6oUI34uGY9iXyA0
         8h4DxMGhVwoYMEkR6wg1vdXP0KP1xs0TKhkfNE68nXUCYGtvAwNfnS9aGoISy5sTTe1Z
         nIVBsGBj/5YqNvgRDOBOnVYLHWHRecDph4hOdkOywlvBi7/7A4HYoSwstN+BE8zy7YI1
         4uv28h/AGqU99uKW+7VxJQ6Dy7OOZ53a371WS8kDrJqlx/Ak2i5z02mm0G++6QqbGUFr
         JdaoHODKJEEpmoFzalD522aKHHC6XBdqoNK7KLHKD2gv/Z3qNVD1fsc4WtLw//Yv4vtB
         3ZxQ==
X-Gm-Message-State: AC+VfDwkhPB5D7HlxhJg1oeRvE6dds2qY0w/GjuA+QA3CjdE5Ev6CRXv
        F9PCsrA3lGCbtLyBJjSBTGmwv+ZvrZaf2oG2mk0y5XpAkMWnre5SulXSPybr618+cAhwVJhFl6+
        z4XVefFYtkLnfSEir4sCGE+PdqIt7URLYCJuC
X-Received: by 2002:a7b:c857:0:b0:3f4:447d:f74a with SMTP id c23-20020a7bc857000000b003f4447df74amr3297127wml.26.1686079658821;
        Tue, 06 Jun 2023 12:27:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5IEVog0t8fkXbxctFdxLSqCnJ3npmPG1gHqTNVuxWkK9uBrkcOSKTsqZD9uU5vZINzapm17g==
X-Received: by 2002:a7b:c857:0:b0:3f4:447d:f74a with SMTP id c23-20020a7bc857000000b003f4447df74amr3297112wml.26.1686079658517;
        Tue, 06 Jun 2023 12:27:38 -0700 (PDT)
Received: from debian (2a01cb058d652b00fa0f162c47a2f35b.ipv6.abo.wanadoo.fr. [2a01:cb05:8d65:2b00:fa0f:162c:47a2:f35b])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bca4f000000b003f733c1129fsm11425908wml.33.2023.06.06.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 12:27:37 -0700 (PDT)
Date:   Tue, 6 Jun 2023 21:27:36 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: POSSIBLE BUG: selftests/net/fcnal-test.sh: [FAIL] in vrf "bind -
 ns-B IPv6 LLA" test
Message-ID: <ZH+IqBNan5nAFMZZ@debian>
References: <b6191f90-ffca-dbca-7d06-88a9788def9c@alu.unizg.hr>
 <ZHeN3bg28pGFFjJN@debian>
 <a379796a-5cd6-caa7-d11d-5ffa7419b90e@alu.unizg.hr>
 <ZH84zGEODT97TEXG@debian>
 <60f78eaa-ace7-c27d-8e45-4777ecf3faa2@alu.unizg.hr>
 <ZH8+jLjottBw2zuD@debian>
 <12c34bed-0885-3bb3-257f-3b2438ba206f@alu.unizg.hr>
 <ZH+ADF0OOcmtUPw9@debian>
 <174c6928-3498-8fb0-9f83-b01fa346a221@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174c6928-3498-8fb0-9f83-b01fa346a221@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 06, 2023 at 09:17:24PM +0200, Mirsad Goran Todorovac wrote:
> On 6/6/23 20:50, Guillaume Nault wrote:
> > On Tue, Jun 06, 2023 at 04:28:02PM +0200, Mirsad Todorovac wrote:
> > > On 6/6/23 16:11, Guillaume Nault wrote:
> > > > On Tue, Jun 06, 2023 at 03:57:35PM +0200, Mirsad Todorovac wrote:
> > > > > +       if (oif) {
> > > > > +               rcu_read_lock();
> > > > > +               dev = dev_get_by_index_rcu(net, oif);
> > > > > +               rcu_read_unlock();
> > > > 
> > > > You can't assume '*dev' is still valid after rcu_read_unlock() unless
> > > > you hold a reference on it.
> > > > 
> > > > > +               rtnl_lock();
> > > > > +               mdev = netdev_master_upper_dev_get(dev);
> > > > > +               rtnl_unlock();
> > > > 
> > > > Because of that, 'dev' might have already disappeared at the time
> > > > netdev_master_upper_dev_get() is called. So it may dereference an
> > > > invalid pointer here.
> > > 
> > > Good point, thanks. I didn't expect those to change.
> > > 
> > > This can be fixed, provided that RCU and RTNL locks can be nested:
> > 
> > Well, yes and no. You can call rcu_read_{lock,unlock}() while under the
> > rtnl protection, but not the other way around.
> > 
> > >          rcu_read_lock();
> > >          if (oif) {
> > >                  dev = dev_get_by_index_rcu(net, oif);
> > >                  rtnl_lock();
> > >                  mdev = netdev_master_upper_dev_get(dev);
> > >                  rtnl_unlock();
> > >          }
> > 
> > This is invalid: rtnl_lock() uses a mutex, so it can sleep and that's
> > forbidden inside an RCU critical section.
> 
> Obviously, that's bad. Mea culpa.
> 
> > >          if (sk->sk_bound_dev_if) {
> > >                  bdev = dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
> > >          }
> > > 
> > >          addr_type = ipv6_addr_type(daddr);
> > >          if ((__ipv6_addr_needs_scope_id(addr_type) && !oif) ||
> > >              (addr_type & IPV6_ADDR_MAPPED) ||
> > >              (oif && sk->sk_bound_dev_if && oif != sk->sk_bound_dev_if &&
> > >                      !(mdev && sk->sk_bound_dev_if && bdev && mdev == bdev))) {
> > >                  rcu_read_unlock();
> > >                  return -EINVAL;
> > > 	}
> > >          rcu_read_unlock();
> > > 
> > > But again this is still probably not race-free (bdev might also disappear before
> > > the mdev == bdev test), even if it passed fcnal-test.sh, there is much duplication
> > > of code, so your one-line solution is obviously by far better. :-)
> > 
> > The real problem is choosing the right function for getting the master
> > device. In particular netdev_master_upper_dev_get() was a bad choice.
> > It forces you to take the rtnl, which is unnatural here and obliges you
> > to add extra code, while all this shouldn't be necessary in the first
> > place.
> 
> Thank you for the additional insight. I had poor luck with Googling on
> these.
> 
> I made a blunder after blunder. But it was insightful and brainstorming.
> Good exercise for my little grey cells.
> 
> However, learning without making any errors appears to be simply a lot
> of blunt memorising. :-/
> 
> It's good to be in an environment when one can learn from errors.
> 
> :-)

I'm happy you found this useful.

> Regards,
> Mirsad
> 

