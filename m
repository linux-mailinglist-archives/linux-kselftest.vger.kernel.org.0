Return-Path: <linux-kselftest+bounces-48580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF69D06C27
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 02:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA36C3010AAE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 01:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237AE2356BA;
	Fri,  9 Jan 2026 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="C5dN/yp6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DD22A4F6
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767922756; cv=none; b=D6U0yYUCYVB580HFkRucVBm1ucGzepFOiZT0k1Ahuk0DAZclHPhpxwoK+V5VRRFn3hvkckVPEro9nqImcA0dg9ipJARxZKjJrbjJdYWPW9ZM67PqBmvD0+sqfQDkJnZ/UoHKb+ASRiPzBgFbmBj7XB8rHBMME9T/sw77uGAHHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767922756; c=relaxed/simple;
	bh=PPC7NX2ky94z97LL+o2Dliiog79NuXV9wEsI2rx2Zcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pBendV4jHNqLX3flZ2ZNzezgZ7izgK3e4yQlQxgQuA68NrM07ovyg9o1EOaEM5khfIexCeMzGfWYKOxugPDfFRZtTNTYdVtLlUydnWExzLL1okch5469Em8EbDVzTcGTOQCkYxMSqIUKguAxChkFEiwFpkQ+2CX7yXrTa5Xj5DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=C5dN/yp6; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ae29ddaed9so1255269eec.0
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Jan 2026 17:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1767922754; x=1768527554; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dJvo7ueweLLuRHlCgBfnBfMmqli0qvfiVgRtcT1/2SE=;
        b=C5dN/yp68GIuTBRhA7mH80jsHJEDqW6yg+mN1ZGpOpyjujAqFYmsxy4CYKr7oQQv/A
         rguT144/zBCIPO8pppGllnJTyXlzGLGP6aWDZSZMpO2dSZkBEMIBnl0P+UW4TVWY+5JM
         2EvR52HzZ3yR5rhC6NlyjPk8B37iMm5aFWrVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767922754; x=1768527554;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJvo7ueweLLuRHlCgBfnBfMmqli0qvfiVgRtcT1/2SE=;
        b=wQBsvjZ/Emkf8JXNXB2ZteiEG9n6kAzgyk/f/B8+JmB+8/fyIKqoYHHTEaHOUMoy06
         MeoIJKn8BPvNOnCfucwQ2wd/1N/Crhnu3OclNfvCla46fGBqCH+rnjG1VUd5b8hi8Wly
         UbFdxEPmo6RZWasl5+w4obcyZwp0nSFCd5yJlMsceBa5QFL/M+gDFyEnqstKMICC8Wi6
         UFwfDCxg0VUYNnk+FR4/WVGdKUzySNR+w6Uirbjpi6eVZanDFEeBAMtlKyLTIXufLW/y
         xIkTD9TxU5XsYbpDSGxlKoANx4XHiaU5HxBFv+UAtJspX2jJ4fM5Fe/szO3BbPhU6p3E
         RmRw==
X-Forwarded-Encrypted: i=1; AJvYcCX8OuJlomxJpIsXKn4LW3JyEgJOBCzuiVog2BE4b69LRH5EViW+UZJ3bDlVMWiSCXXLdKyxob2nbeWXI2I3klg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqmCeZPMc0o89psQBP9gD8TqZAVgZ9zWvhaOMXfxKO3S185wCY
	KBtehf5l3Fs021WUdHmAktcQ46ocecR7bs53oHW4tt1lXECvZz20XdV2WDjD5vAggbU=
X-Gm-Gg: AY/fxX4N6aUYgOAYrBvy/e3UfEOxCJ8P3c+PlAiofuInbKaswXf1bDPt1RHXI/p7HOg
	Fa5+S5OUpWrqnvzLJx1roffWeEVsvVB+akapzOyxg662C8H2XjoI98lKMhRe8TJOf2zTOt3dahy
	Wb0ZBMjkxTNgQcKQX3iTZTW8zvQEzi2gJgKBYEYPc524ruGWDhM2Im+pbew8ksaN8Ed80wGtHLJ
	vwREH/LGaaLwVuH/NGT89kVVKJP1LpWhKnj0ydHhEiG3H/TXEpO7pg+nBBo/lkJgY2U0u/f3OC1
	X0yK61HjZhjKyQ/4nsENpEpNOou3U4g/Uo6/alrN1U+cPJX596AMdPoESYeDgsnsHFgRR1vL3Z/
	83Xs7vL8pVpXhDzYNdyGE7RSbTDfTDspb33epf/yyun+WwDk1sqtRlgf8uqF8W/DLdQiMQIRFm/
	w30sAwdApq
X-Google-Smtp-Source: AGHT+IHoUVHypybcTgdklE8/ULnSnVrNSakulYa/6M6TJUePbDMMkN93P2CjKbVcyXpJbfsc0ucH0w==
X-Received: by 2002:a05:7022:fa04:b0:11a:fb0a:ceca with SMTP id a92af1059eb24-121f1b1f568mr8380710c88.16.1767922753532;
        Thu, 08 Jan 2026 17:39:13 -0800 (PST)
Received: from localhost ([71.219.3.177])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f248bb6esm15223052c88.12.2026.01.08.17.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:39:12 -0800 (PST)
Date: Thu, 8 Jan 2026 20:39:11 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 3/8] rcu/nocb: Remove unnecessary WakeOvfIsDeferred
 wake path
Message-ID: <20260109013911.GA1102915@joelbox2>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-4-joelagnelf@nvidia.com>
 <aV_T5kLzX2qMpxpt@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aV_T5kLzX2qMpxpt@localhost.localdomain>

On Thu, Jan 08, 2026 at 04:57:26PM +0100, Frederic Weisbecker wrote:
> Le Thu, Jan 01, 2026 at 11:34:12AM -0500, Joel Fernandes a écrit :
> > @@ -974,8 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
> >  		return false;
> >  	}
> >  
> > -	ndw = rdp_gp->nocb_defer_wakeup;
> > -	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
> > +	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);
> 
> The force parameter can now be removed, right? (same applies to wake_nocb_gp()).
> 
> Other than that:
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Ah true! Thanks, so the following hunk needs to be squashed into the patch
then, with the review tag. Boqun, if you want to do that please do, or I can
send it again for the next merge window.

---8<-----------------------

From: "Joel Fernandes" <joelagnelf@nvidia.com>
Subject: [PATCH] fixup! rcu/nocb: Remove unnecessary WakeOvfIsDeferred wake
 path

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/rcu/tree.c      |  2 +-
 kernel/rcu/tree.h      |  2 +-
 kernel/rcu/tree_nocb.h | 14 +++++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 293bbd9ac3f4..2921ffb19939 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3769,7 +3769,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	}
 	rcu_nocb_unlock(rdp);
 	if (wake_nocb)
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 	smp_store_release(&rdp->barrier_seq_snap, gseq);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 653fb4ba5852..7dfc57e9adb1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -499,7 +499,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp);
 static struct swait_queue_head *rcu_nocb_gp_get(struct rcu_node *rnp);
 static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
+static bool wake_nocb_gp(struct rcu_data *rdp);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static void call_rcu_nocb(struct rcu_data *rdp, struct rcu_head *head,
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index daff2756cd90..c6f1ddecc2d8 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -192,7 +192,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 
 static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 			   struct rcu_data *rdp,
-			   bool force, unsigned long flags)
+			   unsigned long flags)
 	__releases(rdp_gp->nocb_gp_lock)
 {
 	bool needwake = false;
@@ -225,13 +225,13 @@ static bool __wake_nocb_gp(struct rcu_data *rdp_gp,
 /*
  * Kick the GP kthread for this NOCB group.
  */
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
-	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
+	return __wake_nocb_gp(rdp_gp, rdp, flags);
 }
 
 #ifdef CONFIG_RCU_LAZY
@@ -553,7 +553,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 					   TPS("WakeLazy"));
 		} else if (!irqs_disabled_flags(flags)) {
 			/* ... if queue was empty ... */
-			wake_nocb_gp(rdp, false);
+			wake_nocb_gp(rdp);
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("WakeEmpty"));
 		} else {
@@ -959,7 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
 		return false;
 	}
 
-	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);
+	ret = __wake_nocb_gp(rdp_gp, rdp, flags);
 	trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("DeferredWake"));
 
 	return ret;
@@ -1255,7 +1255,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		}
 		rcu_nocb_try_flush_bypass(rdp, jiffies);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
-		wake_nocb_gp(rdp, false);
+		wake_nocb_gp(rdp);
 		sc->nr_to_scan -= _count;
 		count += _count;
 		if (sc->nr_to_scan <= 0)
@@ -1640,7 +1640,7 @@ static void rcu_init_one_nocb(struct rcu_node *rnp)
 {
 }
 
-static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
+static bool wake_nocb_gp(struct rcu_data *rdp)
 {
 	return false;
 }
-- 
2.34.1


